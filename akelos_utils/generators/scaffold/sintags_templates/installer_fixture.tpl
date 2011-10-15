<?php  echo '<?php'?>

require_once(AK_BASE_DIR.DS.'app'.DS.'installers'.<?php 
echo !empty($module_prefix) ? "DS.'".trim($module_prefix,DS)."'." : ''
?>DS.substr(strrchr(__FILE__, DS), 1));

?>
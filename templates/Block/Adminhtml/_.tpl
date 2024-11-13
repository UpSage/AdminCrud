<?php

 namespace {{Vendor}}\{{Module}}\Block\Adminhtml;
 
 class {{Module}} extends \Magento\Backend\Block\Widget\Grid\Container {
    
  protected function _construct() {
   $this->_blockGroup = '{{Vendor}}_{{Module}}';
   $this->_controller = 'adminhtml_{{module}}';
   $this->_headerText = __('{{Module}}s');
   $this->_addButtonLabel = __('Add New {{Module}}');
   parent::_construct();
  }

 }

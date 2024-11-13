<?php

 namespace {{Vendor}}\{{Module}}\Controller\Adminhtml;
 
 abstract class {{Module}} extends \Magento\Backend\App\Action {
    
  const ADMIN_RESOURCE = '{{Vendor}}_{{Module}}::{{module}}';
  
  protected $_coreRegistry;
  
  public function __construct(\Magento\Backend\App\Action\Context $context, \Magento\Framework\Registry $coreRegistry) {
   $this->_coreRegistry = $coreRegistry;
   parent::__construct($context);
  }
  
  protected function initPage($resultPage) {
   $resultPage
    ->setActiveMenu('{{Vendor}}_{{Module}}::{{module}}')
    ->addBreadcrumb(__('{{Module}}'), __('{{Module}}'))
    ->addBreadcrumb(__('Manage {{Module}}s'), __('Manage {{Module}}s'));
   return $resultPage;
  }

 }
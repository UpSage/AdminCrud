<?php

 declare(strict_types=1);
 
 namespace {{Vendor}}\{{Module}}\Model\Template;
 
 class FilterProvider {
    
  protected $_objectManager;
  
  protected $_{{module}}Filter;
  
  protected $_instanceList;
  
  public function __construct(
   \Magento\Framework\ObjectManagerInterface $objectManager,
   ${{module}}Filter = \{{Vendor}}\{{Module}}\Model\Template\Filter::class
  ) {
   $this->_objectManager = $objectManager;
   $this->_{{module}}Filter = ${{module}}Filter;
  }
  
  protected function _getFilterInstance($instanceName) {
   if(!isset($this->_instanceList[$instanceName])) {
    $instance = $this->_objectManager->get($instanceName);
    if(!$instance instanceof \Magento\Framework\Filter\Template) {
     throw new \Exception('Template filter ' . $instanceName . ' does not implement required interface');
    }
    $this->_instanceList[$instanceName] = $instance;
   }
   return $this->_instanceList[$instanceName];
  }
  
  public function get{{Module}}Filter() {
   return $this->_getFilterInstance($this->_{{module}}Filter);
  }

 }
<?php

 declare(strict_types=1);
 
 namespace {{Vendor}}\{{Module}}\Block\Widget;
 
 use Magento\Framework\DataObject\IdentityInterface;
 use Magento\Framework\Exception\NoSuchEntityException;
 use {{Vendor}}\{{Module}}\Model\{{Module}} as g{{Module}};
 use Magento\Widget\Block\BlockInterface;
 
 class {{Module}} extends \Magento\Framework\View\Element\Template implements BlockInterface, IdentityInterface {
    
  protected $_filterProvider;
  
  protected static $_widgetUsageMap = [];
  
  protected $_{{module}}Factory;
  
  private ${{module}};
  
  public function __construct(
   \Magento\Framework\View\Element\Template\Context $context,
   \{{Vendor}}\{{Module}}\Model\Template\FilterProvider $filterProvider,
   \{{Vendor}}\{{Module}}\Model\{{Module}}Factory ${{module}}Factory,
   array $data = []
  ) {
   parent::__construct($context, $data);
   $this->_filterProvider = $filterProvider;
   $this->_{{module}}Factory = ${{module}}Factory;
  }
  
  protected function _beforeToHtml() {
   parent::_beforeToHtml();
   ${{module}}Id = $this->getData('{{module}}_id');
   ${{module}}Hash = get_class($this) . ${{module}}Id;
   if(isset(self::$_widgetUsageMap[${{module}}Hash])) {
    return $this;
   }
   self::$_widgetUsageMap[${{module}}Hash] = true;
   ${{module}} = $this->get{{Module}}();
   
   if(${{module}} && ${{module}}->isActive()) {
    try {
     $storeId = $this->getData('store_id') ?? $this->_storeManager->getStore()->getId();
     $this->setText(
      $this->_filterProvider->get{{Module}}Filter()->setStoreId($storeId)->filter(${{module}}->getContent())
     );
    } catch (NoSuchEntityException $e) {}
   }
   unset(self::$_widgetUsageMap[${{module}}Hash]);
   return $this;
  }
  
  public function getIdentities() {
   ${{module}} = $this->get{{Module}}();
   if(${{module}}) {
    return ${{module}}->getIdentities();
   }
   return [];
  }
  
  private function get{{Module}}(): ? g{{Module}} {
   if($this->{{module}}) {
    return $this->{{module}};
   }
   ${{module}}Id = $this->getData('{{module}}_id');
   if(${{module}}Id) {
    try {
     $storeId = $this->_storeManager->getStore()->getId();
     ${{module}} = $this->_{{module}}Factory->create();
     ${{module}}->setStoreId($storeId)->load(${{module}}Id);
     $this->{{module}} = ${{module}};
     return ${{module}};
    } catch (NoSuchEntityException $e) {}
   }
   return null;
  }

 }

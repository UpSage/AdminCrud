<?php

 namespace {{Vendor}}\{{Module}}\Block;
 
 use Magento\Framework\View\Element\AbstractBlock;
 
 class {{Module}} extends AbstractBlock implements \Magento\Framework\DataObject\IdentityInterface {
    
  const CACHE_KEY_PREFIX = '{{MODULE}}_';
  
  protected $_filterProvider;
  
  protected $_storeManager;
  
  protected $_{{module}}Factory;
  
  public function __construct(
   \Magento\Framework\View\Element\Context $context,
   \{{Vendor}}\{{Module}}\Model\Template\FilterProvider $filterProvider,
   \Magento\Store\Model\StoreManagerInterface $storeManager,
   \{{Vendor}}\{{Module}}\Model\{{Module}}Factory ${{module}}Factory,
   array $data = []
  ) {
   parent::__construct($context, $data);
   $this->_filterProvider = $filterProvider;
   $this->_storeManager = $storeManager;
   $this->_{{module}}Factory = ${{module}}Factory;
  }
  
  protected function _toHtml() {
   ${{module}}Id = $this->get{{Module}}Id();
   $html = '';
   if(${{module}}Id) {
    $storeId = $this->_storeManager->getStore()->getId();
    ${{module}} = $this->_{{module}}Factory->create();
    ${{module}}->setStoreId($storeId)->load(${{module}}Id);
    if(${{module}}->isActive()) {
     $html = $this->_filterProvider->get{{Module}}Filter()->setStoreId($storeId)->filter(${{module}}->getContent());
    }
   }
   return $html;
  }
  
  public function getIdentities() {
   return [\{{Vendor}}\{{Module}}\Model\{{Module}}::CACHE_TAG . '_' . $this->get{{Module}}Id()];
  }
  
  public function getCacheKeyInfo() {
   $cacheKeyInfo = parent::getCacheKeyInfo();
   $cacheKeyInfo[] = $this->_storeManager->getStore()->getId();
   return $cacheKeyInfo;
  }

 }
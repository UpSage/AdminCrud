<?php

 declare(strict_types=1);
 
 namespace {{Vendor}}\{{Module}}\Model\Config\Source;
 
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\CollectionFactory;
 use Magento\Framework\Data\OptionSourceInterface;
 
 class {{Module}} implements OptionSourceInterface {
    
  private $options;
  
  private $collectionFactory;
  
  public function __construct(
   CollectionFactory $collectionFactory
  ) {
   $this->collectionFactory = $collectionFactory;
  }
  
  public function toOptionArray() {
   if(!$this->options) {
    $this->options = $this->collectionFactory->create()->toOptionIdArray();
   }
   return $this->options;
  }

 }
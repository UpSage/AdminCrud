<?php

 namespace {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Relation\Store;
 
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}};
 use Magento\Framework\EntityManager\Operation\ExtensionInterface;
 
 class ReadHandler implements ExtensionInterface {
    
  protected $resource{{Module}};
  
  public function __construct(
   {{Module}} $resource{{Module}}
  ) {
   $this->resource{{Module}} = $resource{{Module}};
  }
  
  public function execute($entity, $arguments = []) {
   if($entity->getId()) {
    $stores = $this->resource{{Module}}->lookupStoreIds((int)$entity->getId());
    $entity->setData('store_id', $stores);
    $entity->setData('stores', $stores);
   }
   return $entity;
  }

 }
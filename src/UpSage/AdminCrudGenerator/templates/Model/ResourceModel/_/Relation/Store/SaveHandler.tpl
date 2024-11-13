<?php

 namespace {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Relation\Store;
 
 use Magento\Framework\EntityManager\Operation\ExtensionInterface;
 use {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}};
 use Magento\Framework\EntityManager\MetadataPool;
 
 class SaveHandler implements ExtensionInterface {
    
  protected $metadataPool;
  
  protected $resource{{Module}};
  
  public function __construct(
   MetadataPool $metadataPool,
   {{Module}} $resource{{Module}}
  ) {
   $this->metadataPool = $metadataPool;
   $this->resource{{Module}} = $resource{{Module}};
  }
  
  public function execute($entity, $arguments = []) {
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   $linkField = $entityMetadata->getLinkField();
   $connection = $entityMetadata->getEntityConnection();
   $oldStores = $this->resource{{Module}}->lookupStoreIds((int)$entity->getId());
   $newStores = (array)$entity->getStores();
   $table = $this->resource{{Module}}->getTable('{{vendor}}_{{module}}_store');
   $delete = array_diff($oldStores, $newStores);
   if($delete) {
    $where = [
     $linkField . ' = ?' => (int)$entity->getData($linkField),
     'store_id IN (?)' => $delete,
    ];
    $connection->delete($table, $where);
   }
   $insert = array_diff($newStores, $oldStores);
   if($insert) {
    $data = [];
    foreach($insert as $storeId) {
     $data[] = [
      $linkField => (int)$entity->getData($linkField),
      'store_id' => (int)$storeId,
     ];
    }
    $connection->insertMultiple($table, $data);
   }
   return $entity;
  }

 }
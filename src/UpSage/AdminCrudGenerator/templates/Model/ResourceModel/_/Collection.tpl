<?php

 namespace {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}};
 
 use {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 use \{{Vendor}}\{{Module}}\Model\ResourceModel\AbstractCollection;
 
 class Collection extends AbstractCollection {
    
  protected $_idFieldName = '{{module}}_id';
  
  protected $_eventPrefix = '{{vendor}}_{{module}}_collection';
  
  protected $_eventObject = '{{module}}_collection';
  
  protected function _afterLoad() {
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   $this->performAfterLoad('{{vendor}}_{{module}}_store', $entityMetadata->getLinkField());
   return parent::_afterLoad();
  }
  
  protected function _construct() {
   $this->_init(\{{Vendor}}\{{Module}}\Model\{{Module}}::class, \{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}::class);
   $this->_map['fields']['store'] = 'store_table.store_id';
   $this->_map['fields']['{{module}}_id'] = 'main_table.{{module}}_id';
  }
  
  public function toOptionArray() {
   return $this->_toOptionArray('{{module}}_id', 'title');
  }
  
  public function addStoreFilter($store, $withAdmin = true) {
   $this->performAddStoreFilter($store, $withAdmin);
   return $this;
  }
  
  protected function _renderFiltersBefore() {
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   $this->joinStoreRelationTable('{{vendor}}_{{module}}_store', $entityMetadata->getLinkField());
  }

 }
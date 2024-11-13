<?php

 namespace {{Vendor}}\{{Module}}\Model\ResourceModel;
 
 use {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 use Magento\Framework\DB\Select;
 use Magento\Framework\EntityManager\EntityManager;
 use Magento\Framework\EntityManager\MetadataPool;
 use Magento\Framework\Exception\LocalizedException;
 use Magento\Framework\Model\AbstractModel;
 use Magento\Framework\Model\ResourceModel\Db\AbstractDb;
 use Magento\Framework\Model\ResourceModel\Db\Context;
 use Magento\Store\Model\Store;
 use Magento\Store\Model\StoreManagerInterface;
 
 class {{Module}} extends AbstractDb {
    
  protected $_storeManager;
  
  protected $entityManager;
  
  protected $metadataPool;
  
  public function __construct(
   Context $context,
   StoreManagerInterface $storeManager,
   EntityManager $entityManager,
   MetadataPool $metadataPool,
   $connectionName = null
  ) {
   $this->_storeManager = $storeManager;
   $this->entityManager = $entityManager;
   $this->metadataPool = $metadataPool;
   parent::__construct($context, $connectionName);
  }
  
  protected function _construct() {
   $this->_init('{{vendor}}_{{module}}', '{{module}}_id');
  }
  
  public function getConnection() {
   return $this->metadataPool->getMetadata({{Module}}Interface::class)->getEntityConnection();
  }
  
  protected function _beforeSave(AbstractModel $object) {
   if(!$this->getIsUnique{{Module}}ToStores($object)) {
    throw new LocalizedException(
     __('A {{module}} identifier with the same properties already exists in the selected store.')
    );
   }
   return $this;
  }
  
  private function get{{Module}}Id(AbstractModel $object, $value, $field = null) {
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   if(!is_numeric($value) && $field === null) {
    $field = 'identifier';
   } elseif (!$field) {
    $field = $entityMetadata->getIdentifierField();
   }
   $entityId = $value;
   if($field != $entityMetadata->getIdentifierField() || $object->getStoreId()) {
    $select = $this->_getLoadSelect($field, $value, $object);
    $select->reset(Select::COLUMNS)
     ->columns($this->getMainTable() . '.' . $entityMetadata->getIdentifierField())
     ->limit(1);
    $result = $this->getConnection()->fetchCol($select);
    $entityId = count($result) ? $result[0] : false;
   }
   return $entityId;
  }
  
  public function load(AbstractModel $object, $value, $field = null) {
   ${{module}}Id = $this->get{{Module}}Id($object, $value, $field);
   if(${{module}}Id) {
    $this->entityManager->load($object, ${{module}}Id);
   }
   return $this;
  }
  
  protected function _getLoadSelect($field, $value, $object) {
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   $linkField = $entityMetadata->getLinkField();
   $select = parent::_getLoadSelect($field, $value, $object);
   if($object->getStoreId()) {
    $stores = [(int)$object->getStoreId(), Store::DEFAULT_STORE_ID];
    $select->join(
     ['ums' => $this->getTable('{{vendor}}_{{module}}_store')],
     $this->getMainTable() . '.' . $linkField . ' = ums.' . $linkField,
     ['store_id']
    )
    ->where('is_active = ?', 1)
    ->where('ums.store_id in (?)', $stores)
    ->order('store_id DESC')
    ->limit(1);
   }
   return $select;
  }
  
  public function getIsUnique{{Module}}ToStores(AbstractModel $object) {
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   $linkField = $entityMetadata->getLinkField();
   $stores = $this->_storeManager->isSingleStoreMode() ? [Store::DEFAULT_STORE_ID] : (array)$object->getData('store_id');
   $select = $this->getConnection()->select()
   ->from(['um' => $this->getMainTable()])
   ->join(
    ['ums' => $this->getTable('{{vendor}}_{{module}}_store')],
    'um.' . $linkField . ' = ums.' . $linkField,
    []
   )
   ->where('um.identifier = ?', $object->getData('identifier'))
   ->where('ums.store_id IN (?)', $stores);
   if($object->getId()) {
    $select->where('um.' . $entityMetadata->getIdentifierField() . ' <> ?', $object->getId());
   }
   return !$this->getConnection()->fetchRow($select);
  }
  
  public function lookupStoreIds($id) {
   $connection = $this->getConnection();
   $entityMetadata = $this->metadataPool->getMetadata({{Module}}Interface::class);
   $linkField = $entityMetadata->getLinkField();
   $select = $connection->select()
   ->from(['ums' => $this->getTable('{{vendor}}_{{module}}_store')], 'store_id')
   ->join(
    ['um' => $this->getMainTable()],
    'ums.' . $linkField . ' = um.' . $linkField,
    []
   )
   ->where('um.' . $entityMetadata->getIdentifierField() . ' = :{{module}}_id');
   return $connection->fetchCol($select, ['{{module}}_id' => (int)$id]);
  }
  
  public function save(AbstractModel $object) {
   $this->entityManager->save($object);
   return $this;
  }
  
  public function delete(AbstractModel $object) {
   $this->entityManager->delete($object);
   return $this;
  }

 }
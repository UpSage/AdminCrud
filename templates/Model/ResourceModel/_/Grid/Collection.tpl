<?php

 namespace {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Grid;
 
 use Magento\Framework\Api\Search\SearchResultInterface;
 use Magento\Framework\Api\Search\AggregationInterface;
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Collection as {{Module}}Collection;
 use Magento\Framework\App\ObjectManager;
 use Magento\Framework\Data\Collection\Db\FetchStrategyInterface;
 use Magento\Framework\Data\Collection\EntityFactoryInterface;
 use Magento\Framework\DB\Adapter\AdapterInterface;
 use Magento\Framework\EntityManager\MetadataPool;
 use Magento\Framework\Event\ManagerInterface;
 use Magento\Framework\Model\ResourceModel\Db\AbstractDb;
 use Magento\Framework\Stdlib\DateTime\TimezoneInterface;
 use Magento\Store\Model\StoreManagerInterface;
 use Psr\Log\LoggerInterface;
 
 class Collection extends {{Module}}Collection implements SearchResultInterface {
    
  private $timeZone;
  
  protected $aggregations;
  
  public function __construct(
   EntityFactoryInterface $entityFactory,
   LoggerInterface $logger,
   FetchStrategyInterface $fetchStrategy,
   ManagerInterface $eventManager,
   StoreManagerInterface $storeManager,
   MetadataPool $metadataPool,
   $mainTable,
   $eventPrefix,
   $eventObject,
   $resourceModel,
   $model = \Magento\Framework\View\Element\UiComponent\DataProvider\Document::class,
   $connection = null,
   AbstractDb $resource = null,
   TimezoneInterface $timeZone = null
  ) {
   parent::__construct(
    $entityFactory,
    $logger,
    $fetchStrategy,
    $eventManager,
    $storeManager,
    $metadataPool,
    $connection,
    $resource
   );
   $this->_eventPrefix = $eventPrefix;
   $this->_eventObject = $eventObject;
   $this->_init($model, $resourceModel);
   $this->setMainTable($mainTable);
   $this->timeZone = $timeZone ?: ObjectManager::getInstance()->get(TimezoneInterface::class);
  }
  
  public function addFieldToFilter($field, $condition = null) {
   if($field === 'creation_time' || $field === 'update_time') {
    if(is_array($condition)) {
     foreach($condition as $key => $value) {
      $condition[$key] = $this->timeZone->convertConfigTimeToUtc($value);
     }
    }
   }
   return parent::addFieldToFilter($field, $condition);
  }
  
  public function getAggregations() {
   return $this->aggregations;
  }
  
  public function setAggregations($aggregations) {
   $this->aggregations = $aggregations;
   return $this;
  }
  
  public function getSearchCriteria() {
   return null;
  }
  
  public function setSearchCriteria(\Magento\Framework\Api\SearchCriteriaInterface $searchCriteria = null) {
   return $this;
  }
  
  public function getTotalCount() {
   return $this->getSize();
  }
  
  public function setTotalCount($totalCount) {
   return $this;
  }
  
  public function setItems(array $items = null) {
   return $this;
  }

 }
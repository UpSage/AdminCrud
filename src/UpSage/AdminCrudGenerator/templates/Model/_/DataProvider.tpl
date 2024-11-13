<?php

 namespace {{Vendor}}\{{Module}}\Model\{{Module}};
 
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\CollectionFactory;
 use Magento\Framework\App\Request\DataPersistorInterface;
 use Magento\Ui\DataProvider\Modifier\PoolInterface;
 
 class DataProvider extends \Magento\Ui\DataProvider\ModifierPoolDataProvider {
    
  protected $collection;
  
  protected $dataPersistor;
  
  protected $loadedData;
  
  public function __construct(
   $name,
   $primaryFieldName,
   $requestFieldName,
   CollectionFactory ${{module}}CollectionFactory,
   DataPersistorInterface $dataPersistor,
   array $meta = [],
   array $data = [],
   PoolInterface $pool = null
  ) {
   $this->collection = ${{module}}CollectionFactory->create();
   $this->dataPersistor = $dataPersistor;
   parent::__construct($name, $primaryFieldName, $requestFieldName, $meta, $data, $pool);
  }
  
  public function getData() {
   if(isset($this->loadedData)) {
    return $this->loadedData;
   }
   $items = $this->collection->getItems();
   foreach($items as ${{module}}) {
    $this->loadedData[${{module}}->getId()] = ${{module}}->getData();
   }
   $data = $this->dataPersistor->get('{{module}}');
   if(!empty($data)) {
    ${{module}} = $this->collection->getNewEmptyItem();
    ${{module}}->setData($data);
    $this->loadedData[${{module}}->getId()] = ${{module}}->getData();
    $this->dataPersistor->clear('{{module}}');
   }
   return $this->loadedData;
  }

 }
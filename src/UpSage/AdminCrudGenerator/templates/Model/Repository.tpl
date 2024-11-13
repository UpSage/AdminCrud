<?php

 namespace {{Vendor}}\{{Module}}\Model;
 
 use {{Vendor}}\{{Module}}\Api\{{Module}}RepositoryInterface;
 use {{Vendor}}\{{Module}}\Api\Data;
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}} as Resource{{Module}};
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\CollectionFactory as {{Module}}CollectionFactory;
 use Magento\Framework\Api\DataObjectHelper;
 use Magento\Framework\Api\SearchCriteria\CollectionProcessorInterface;
 use Magento\Framework\App\ObjectManager;
 use Magento\Framework\Exception\CouldNotDeleteException;
 use Magento\Framework\Exception\CouldNotSaveException;
 use Magento\Framework\Exception\NoSuchEntityException;
 use Magento\Framework\Reflection\DataObjectProcessor;
 use Magento\Store\Model\StoreManagerInterface;
 use Magento\Framework\EntityManager\HydratorInterface;
 
 class {{Module}}Repository implements {{Module}}RepositoryInterface {
    
  protected $resource;
  
  protected ${{module}}Factory;
  
  protected ${{module}}CollectionFactory;
  
  protected $searchResultsFactory;
  
  protected $dataObjectHelper;
  
  protected $dataObjectProcessor;
  
  protected $data{{Module}}Factory;
  
  private $storeManager;
  
  private $collectionProcessor;
  
  private $hydrator;
  
  public function __construct(
   Resource{{Module}} $resource,
   {{Module}}Factory ${{module}}Factory,
   \{{Vendor}}\{{Module}}\Api\Data\{{Module}}InterfaceFactory $data{{Module}}Factory,
   {{Module}}CollectionFactory ${{module}}CollectionFactory,
   Data\{{Module}}SearchResultsInterfaceFactory $searchResultsFactory,
   DataObjectHelper $dataObjectHelper,
   DataObjectProcessor $dataObjectProcessor,
   StoreManagerInterface $storeManager,
   CollectionProcessorInterface $collectionProcessor = null,
   ?HydratorInterface $hydrator = null
  ) {
   $this->resource = $resource;
   $this->{{module}}Factory = ${{module}}Factory;
   $this->{{module}}CollectionFactory = ${{module}}CollectionFactory;
   $this->searchResultsFactory = $searchResultsFactory;
   $this->dataObjectHelper = $dataObjectHelper;
   $this->data{{Module}}Factory = $data{{Module}}Factory;
   $this->dataObjectProcessor = $dataObjectProcessor;
   $this->storeManager = $storeManager;
   $this->collectionProcessor = $collectionProcessor ?: $this->getCollectionProcessor();
   $this->hydrator = $hydrator ?? ObjectManager::getInstance()->get(HydratorInterface::class);
  }
  
  public function save(Data\{{Module}}Interface ${{module}}) {
   if(empty(${{module}}->getStoreId())) {
    ${{module}}->setStoreId($this->storeManager->getStore()->getId());
   }
   if(${{module}}->getId() && ${{module}} instanceof {{Module}} && !${{module}}->getOrigData()) {
    ${{module}} = $this->hydrator->hydrate($this->getById(${{module}}->getId()), $this->hydrator->extract(${{module}}));
   }
   try {
    $this->resource->save(${{module}});
   } catch (\Exception $exception) {
    throw new CouldNotSaveException(__($exception->getMessage()));
   }
   return ${{module}};
  }
  
  public function getById(${{module}}Id) {
   ${{module}} = $this->{{module}}Factory->create();
   $this->resource->load(${{module}}, ${{module}}Id);
   if (!${{module}}->getId()) {
    throw new NoSuchEntityException(__('The {{Module}} with the "%1" ID doesn\'t exist.', ${{module}}Id));
   }
   return ${{module}};
  }
  
  public function getList(\Magento\Framework\Api\SearchCriteriaInterface $criteria) {
   $collection = $this->{{module}}CollectionFactory->create();
   $this->collectionProcessor->process($criteria, $collection);
   $searchResults = $this->searchResultsFactory->create();
   $searchResults->setSearchCriteria($criteria);
   $searchResults->setItems($collection->getItems());
   $searchResults->setTotalCount($collection->getSize());
   return $searchResults;
  }
  
  public function delete(Data\{{Module}}Interface ${{module}}) {
   try {
    $this->resource->delete(${{module}});
   } catch (\Exception $exception) {
    throw new CouldNotDeleteException(__($exception->getMessage()));
   }
   return true;
  }
  
  public function deleteById(${{module}}Id) {
   return $this->delete($this->getById(${{module}}Id));
  }
  
  private function getCollectionProcessor() {
   if (!$this->collectionProcessor) {
    $this->collectionProcessor = \Magento\Framework\App\ObjectManager::getInstance()->get(
     '{{Vendor}}\{{Module}}\Model\Api\SearchCriteria\{{Module}}CollectionProcessor'
    );
   }
   return $this->collectionProcessor;
  }

 }
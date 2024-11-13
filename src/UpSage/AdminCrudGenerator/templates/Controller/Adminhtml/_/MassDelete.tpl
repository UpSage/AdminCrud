<?php

 namespace {{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}};
 
 use Magento\Framework\App\Action\HttpPostActionInterface;
 use Magento\Framework\Controller\ResultFactory;
 use Magento\Backend\App\Action\Context;
 use Magento\Ui\Component\MassAction\Filter;
 use {{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\CollectionFactory;
 
 class MassDelete extends \Magento\Backend\App\Action implements HttpPostActionInterface {
    
  const ADMIN_RESOURCE = '{{Vendor}}_{{Module}}::{{module}}';
  
  protected $filter;
  
  protected $collectionFactory;
  
  public function __construct(Context $context, Filter $filter, CollectionFactory $collectionFactory) {
   $this->filter = $filter;
   $this->collectionFactory = $collectionFactory;
   parent::__construct($context);
  }
  
  public function execute() {
   $collection = $this->filter->getCollection($this->collectionFactory->create());
   $collectionSize = $collection->getSize();
   foreach($collection as ${{module}}) {
    ${{module}}->delete();
   }
   $this->messageManager->addSuccessMessage(__('A total of %1 record(s) have been deleted.', $collectionSize));
   $resultRedirect = $this->resultFactory->create(ResultFactory::TYPE_REDIRECT);
   return $resultRedirect->setPath('*/*/');
  }

 }

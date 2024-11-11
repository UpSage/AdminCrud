<?php

 namespace {{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}};
 
 use Magento\Framework\App\Action\HttpGetActionInterface;
 
 class Edit extends \{{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}} implements HttpGetActionInterface {
    
  protected $resultPageFactory;
  
  public function __construct(
   \Magento\Backend\App\Action\Context $context,
   \Magento\Framework\Registry $coreRegistry,
   \Magento\Framework\View\Result\PageFactory $resultPageFactory
  ) {
   $this->resultPageFactory = $resultPageFactory;
   parent::__construct($context, $coreRegistry);
  }
  
  public function execute() {
   $id = $this->getRequest()->getParam('{{module}}_id');
   $model = $this->_objectManager->create(\{{Vendor}}\{{Module}}\Model\{{Module}}::class);
   if($id) {
    $model->load($id);
    if(!$model->getId()) {
     $this->messageManager->addErrorMessage(__('This {{module}} no longer exists.'));
     $resultRedirect = $this->resultRedirectFactory->create();
     return $resultRedirect->setPath('*/*/');
    }
   }
   $this->_coreRegistry->register('{{vendor}}_{{module}}', $model);
   $resultPage = $this->resultPageFactory->create();
   $this->initPage($resultPage)->addBreadcrumb(
    $id ? __('Edit {{Module}}') : __('New {{Module}}'),
    $id ? __('Edit {{Module}}') : __('New {{Module}}')
   );
   $resultPage->getConfig()->getTitle()->prepend(__('{{Module}}s'));
   $resultPage->getConfig()->getTitle()->prepend($model->getId() ? $model->getTitle() : __('New {{Module}}'));
   return $resultPage;
  }
 
 }
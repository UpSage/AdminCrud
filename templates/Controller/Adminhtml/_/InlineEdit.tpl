<?php

 namespace {{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}};
 
 use Magento\Backend\App\Action\Context;
 use {{Vendor}}\{{Module}}\Api\{{Module}}RepositoryInterface as {{Module}}Repository;
 use Magento\Framework\Controller\Result\JsonFactory;
 use {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 
 class InlineEdit extends \Magento\Backend\App\Action {
    
  const ADMIN_RESOURCE = '{{Vendor}}_{{Module}}::{{module}}';
  
  protected ${{module}}Repository;
  
  protected $jsonFactory;
  
  public function __construct(
   Context $context,
   {{Module}}Repository ${{module}}Repository,
   JsonFactory $jsonFactory
  ) {
   parent::__construct($context);
   $this->{{module}}Repository = ${{module}}Repository;
   $this->jsonFactory = $jsonFactory;
  }
  
  public function execute() {
   $resultJson = $this->jsonFactory->create();
   $error = false;
   $messages = [];
   if($this->getRequest()->getParam('isAjax')) {
    $postItems = $this->getRequest()->getParam('items', []);
    if(!count($postItems)) {
     $messages[] = __('Please correct the data sent.');
     $error = true;
    } else {
     foreach(array_keys($postItems) as ${{module}}Id) {
      ${{module}} = $this->{{module}}Repository->getById(${{module}}Id);
      try {
       ${{module}}->setData(array_merge(${{module}}->getData(), $postItems[${{module}}Id]));
       $this->{{module}}Repository->save(${{module}});
      } catch (\Exception $e) {
       $messages[] = $this->getErrorWith{{Module}}Id(${{module}},__($e->getMessage()));
       $error = true;
      }
     }
    }
   }
   return $resultJson->setData([
    'messages' => $messages,
    'error' => $error
   ]);
  }
  
  protected function getErrorWith{{Module}}Id({{Module}}Interface ${{module}}, $errorText) {
   return '[{{Module}} ID: ' . ${{module}}->getId() . '] ' . $errorText;
  }

 }
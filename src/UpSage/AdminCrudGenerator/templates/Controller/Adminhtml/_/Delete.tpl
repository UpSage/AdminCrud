<?php

 namespace {{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}};
 
 use Magento\Framework\App\Action\HttpPostActionInterface;
 
 class Delete extends \{{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}} implements HttpPostActionInterface {
    
  public function execute() {
   $resultRedirect = $this->resultRedirectFactory->create();
   $id = $this->getRequest()->getParam('{{module}}_id');
   if($id) {
    try {
     $model = $this->_objectManager->create(\{{Vendor}}\{{Module}}\Model\{{Module}}::class);
     $model->load($id);
     $model->delete();
     $this->messageManager->addSuccessMessage(__('You deleted the {{module}}.'));
     return $resultRedirect->setPath('*/*/');
    } catch (\Exception $e) {
     $this->messageManager->addErrorMessage($e->getMessage());
     return $resultRedirect->setPath('*/*/edit', ['{{module}}_id' => $id]);
    }
   }
   $this->messageManager->addErrorMessage(__('We can\'t find a {{module}} to delete.'));
   return $resultRedirect->setPath('*/*/');
  }

 }
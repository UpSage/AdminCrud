<?php

 namespace {{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}};
 
 use Magento\Framework\App\Action\HttpPostActionInterface;
 use Magento\Backend\App\Action\Context;
 use {{Vendor}}\{{Module}}\Api\{{Module}}RepositoryInterface;
 use {{Vendor}}\{{Module}}\Model\{{Module}};
 use {{Vendor}}\{{Module}}\Model\{{Module}}Factory;
 use Magento\Framework\App\Request\DataPersistorInterface;
 use Magento\Framework\Exception\LocalizedException;
 use Magento\Framework\Registry;
 
 class Save extends \{{Vendor}}\{{Module}}\Controller\Adminhtml\{{Module}} implements HttpPostActionInterface {
    
  protected $dataPersistor;
  
  private ${{module}}Factory;
  
  private ${{module}}Repository;
  
  public function __construct(
   Context $context,
   Registry $coreRegistry,
   DataPersistorInterface $dataPersistor,
   {{Module}}Factory ${{module}}Factory = null,
   {{Module}}RepositoryInterface ${{module}}Repository = null
  ) {
   $this->dataPersistor = $dataPersistor;
   $this->{{module}}Factory = ${{module}}Factory ?: \Magento\Framework\App\ObjectManager::getInstance()->get({{Module}}Factory::class);
   $this->{{module}}Repository = ${{module}}Repository ?: \Magento\Framework\App\ObjectManager::getInstance()->get({{Module}}RepositoryInterface::class);
   parent::__construct($context, $coreRegistry);
  }
  
  public function execute() {
   $resultRedirect = $this->resultRedirectFactory->create();
   $data = $this->getRequest()->getPostValue();
   if($data) {
    if(isset($data['is_active']) && $data['is_active'] === 'true') {
     $data['is_active'] = {{Module}}::STATUS_ENABLED;
    }
    if(empty($data['{{module}}_id'])) {
     $data['{{module}}_id'] = null;
    }
    
    $model = $this->{{module}}Factory->create();
    
    $id = $this->getRequest()->getParam('{{module}}_id');
    if($id) {
     try {
      $model = $this->{{module}}Repository->getById($id);
     } catch (LocalizedException $e) {
      $this->messageManager->addErrorMessage(__('This {{module}} no longer exists.'));
      return $resultRedirect->setPath('*/*/');
     }
    }
    
    $model->setData($data);
    
    try {
     $this->{{module}}Repository->save($model);
     $this->messageManager->addSuccessMessage(__('You saved the {{module}}.'));
     $this->dataPersistor->clear('{{vendor}}_{{module}}');
     return $this->process{{Module}}Return($model, $data, $resultRedirect);
    } catch (LocalizedException $e) {
     $this->messageManager->addErrorMessage($e->getMessage());
    } catch (\Exception $e) {
     $this->messageManager->addExceptionMessage($e, __('Something went wrong while saving the {{module}}.'));
    }
    
    $this->dataPersistor->set('{{vendor}}_{{module}}', $data);
    return $resultRedirect->setPath('*/*/edit', ['{{module}}_id' => $id]);

   }
   return $resultRedirect->setPath('*/*/');
  }
  
  private function process{{Module}}Return($model, $data, $resultRedirect) {
   $redirect = $data['back'] ?? 'close';
   if($redirect === 'continue') {
    $resultRedirect->setPath('*/*/edit', ['{{module}}_id' => $model->getId()]);
   } elseif ($redirect === 'close') {
    $resultRedirect->setPath('*/*/');
   } elseif ($redirect === 'duplicate') {
    $duplicateModel = $this->{{module}}Factory->create(['data' => $data]);
    $duplicateModel->setId(null);
    $duplicateModel->setIdentifier($data['identifier'] . '-' . uniqid());
    $duplicateModel->setIsActive({{Module}}::STATUS_DISABLED);
    $this->{{module}}Repository->save($duplicateModel);
    $id = $duplicateModel->getId();
    $this->messageManager->addSuccessMessage(__('You duplicated the {{module}}.'));
    $this->dataPersistor->set('{{vendor}}_{{module}}', $data);
    $resultRedirect->setPath('*/*/edit', ['{{module}}_id' => $id]);
   }
   return $resultRedirect;
  }

 }
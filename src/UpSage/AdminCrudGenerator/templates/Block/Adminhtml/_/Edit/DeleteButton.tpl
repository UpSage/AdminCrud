<?php

 namespace {{Vendor}}\{{Module}}\Block\Adminhtml\{{Module}}\Edit;
 
 use Magento\Framework\View\Element\UiComponent\Control\ButtonProviderInterface;
 
 class DeleteButton extends GenericButton implements ButtonProviderInterface {
    
  public function getButtonData() {
   $data = [];
   if($this->get{{Module}}Id()) {
    $data = [
     'label' => __('Delete {{Module}}'),
     'class' => 'delete',
     'on_click' => 'deleteConfirm(\'' . __('Are you sure you want to do this?') . '\', \'' . $this->getDeleteUrl() . '\', {"data": {}})',
     'sort_order' => 20,
    ];
   }
   return $data;
  }
  
  public function getDeleteUrl() {
   return $this->getUrl('*/*/delete', ['{{module}}_id' => $this->get{{Module}}Id()]);
  }

 }
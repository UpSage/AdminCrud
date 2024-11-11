<?php

 namespace {{Vendor}}\{{Module}}\Block\Adminhtml\{{Module}}\Edit;
 
 use Magento\Backend\Block\Widget\Context;
 use {{Vendor}}\{{Module}}\Api\{{Module}}RepositoryInterface;
 use Magento\Framework\Exception\NoSuchEntityException;
 
 class GenericButton {
    
  protected $context;
  
  protected ${{module}}Repository;
  
  public function __construct(
   Context $context,
   {{Module}}RepositoryInterface ${{module}}Repository
  ) {
   $this->context = $context;
   $this->{{module}}Repository = ${{module}}Repository;
  }
  
  public function get{{Module}}Id() {
   try {
    return $this->{{module}}Repository->getById(
     $this->context->getRequest()->getParam('{{module}}_id')
    )->getId();
   } catch (NoSuchEntityException $e) {}
   return null;
  }
  
  public function getUrl($route = '', $params = []) {
   return $this->context->getUrlBuilder()->getUrl($route, $params);
  }

 }

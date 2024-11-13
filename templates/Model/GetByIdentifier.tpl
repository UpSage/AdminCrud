<?php

 namespace {{Vendor}}\{{Module}}\Model;
 
 use {{Vendor}}\{{Module}}\Api\Get{{Module}}ByIdentifierInterface;
 use {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 use Magento\Framework\Exception\NoSuchEntityException;
 
 class Get{{Module}}ByIdentifier implements Get{{Module}}ByIdentifierInterface {
    
  private ${{module}}Factory;
  
  private ${{module}}Resource;
  
  public function __construct(
   \{{Vendor}}\{{Module}}\Model\{{Module}}Factory ${{module}}Factory,
   \{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}} ${{module}}Resource
  ) {
   $this->{{module}}Factory = ${{module}}Factory;
   $this->{{module}}Resource = ${{module}}Resource;
  }
  
  public function execute(string $identifier, int $storeId): {{Module}}Interface {
   ${{module}} = $this->{{module}}Factory->create();
   ${{module}}->setStoreId($storeId);
   $this->{{module}}Resource->load(${{module}}, $identifier, {{Module}}Interface::IDENTIFIER);
   if(!${{module}}->getId()) {
    throw new NoSuchEntityException(__('The {{module}} with the "%1" ID doesn\'t exist.', $identifier));
   }
   return ${{module}};
  }

 }
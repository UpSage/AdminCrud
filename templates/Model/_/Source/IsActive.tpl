<?php

 namespace {{Vendor}}\{{Module}}\Model\{{Module}}\Source;
 
 use Magento\Framework\Data\OptionSourceInterface;
 
 class IsActive implements OptionSourceInterface {
    
  protected ${{module}};
  
  public function __construct(\Upsage\{{Module}}\Model\{{Module}} ${{module}}) {
   $this->{{module}} = ${{module}};
  }
  
  public function toOptionArray() {
   $availableOptions = $this->{{module}}->getAvailableStatuses();
   $options = [];
   foreach($availableOptions as $key => $value) {
    $options[] = [
     'label' => $value,
     'value' => $key,
    ];
   }
   return $options;
  }

 }
<?php

 namespace {{Vendor}}\{{Module}}\Api;
 
 interface {{Module}}RepositoryInterface {
    
  public function save(Data\{{Module}}Interface ${{module}});
  
  public function getById(${{module}}Id);
  
  public function getList(\Magento\Framework\Api\SearchCriteriaInterface $searchCriteria);
  
  public function delete(Data\{{Module}}Interface ${{module}});
  
  public function deleteById(${{module}}Id);

 }
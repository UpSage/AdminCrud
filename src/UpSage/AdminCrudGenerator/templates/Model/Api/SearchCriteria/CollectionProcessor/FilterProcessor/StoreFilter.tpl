<?php

 namespace {{Vendor}}\{{Module}}\Model\Api\SearchCriteria\CollectionProcessor\FilterProcessor;
 
 use Magento\Framework\Api\Filter;
 use Magento\Framework\Api\SearchCriteria\CollectionProcessor\FilterProcessor\CustomFilterInterface;
 use Magento\Framework\Data\Collection\AbstractDb;
 
 class {{Module}}StoreFilter implements CustomFilterInterface {
    
  public function apply(Filter $filter, AbstractDb $collection) {
   $collection->addStoreFilter($filter->getValue(), false);
   return true;
  }

 }
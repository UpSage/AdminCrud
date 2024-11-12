<?php

 declare(strict_types=1);
 
 namespace {{Vendor}}\{{Module}}\Ui\Component;
 
 use Magento\Framework\Api\Filter;
 use Magento\Framework\Api\Search\SearchCriteriaBuilder;
 
 interface AddFilterInterface {
  public function addFilter(SearchCriteriaBuilder $searchCriteriaBuilder, Filter $filter);
 }
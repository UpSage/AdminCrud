<?php

 namespace {{Vendor}}\{{Module}}\Api\Data;
 
 use Magento\Framework\Api\SearchResultsInterface;
 
 interface {{Module}}SearchResultsInterface extends SearchResultsInterface {
  public function getItems();
  public function setItems(array $items);
 }
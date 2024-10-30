<?php

 namespace {{Vendor}}\{{Module}}\Api;
 
 interface Get{{Module}}ByIdentifierInterface {
  public function execute(string $identifier, int $storeId) : {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 }
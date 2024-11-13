<?xml version="1.0"?>

<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
 <preference for="{{Vendor}}\{{Module}}\Api\Data\{{Module}}SearchResultsInterface" type="{{Vendor}}\{{Module}}\Model\{{Module}}SearchResults" />
 <preference for="{{Vendor}}\{{Module}}\Api\Get{{Module}}ByIdentifierInterface" type="{{Vendor}}\{{Module}}\Model\Get{{Module}}ByIdentifier" />
 <preference for="{{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface" type="{{Vendor}}\{{Module}}\Model\{{Module}}" />
 <preference for="{{Vendor}}\{{Module}}\Api\{{Module}}RepositoryInterface" type="{{Vendor}}\{{Module}}\Model\{{Module}}Repository" />
 <type name="Magento\Framework\View\Element\UiComponent\DataProvider\CollectionFactory">
  <arguments>
   <argument name="collections" xsi:type="array">
    <item name="{{vendor}}_{{module}}_listing_data_source" xsi:type="string">{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Grid\Collection</item>
   </argument>
  </arguments>
 </type>
 <type name="{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Grid\Collection">
  <arguments>
   <argument name="mainTable" xsi:type="string">{{vendor}}_{{module}}</argument>
   <argument name="eventPrefix" xsi:type="string">{{vendor}}_{{module}}_grid_collection</argument>
   <argument name="eventObject" xsi:type="string">{{module}}_grid_collection</argument>
   <argument name="resourceModel" xsi:type="string">{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}</argument>
  </arguments>
 </type>
 <type name="Magento\Framework\Model\Entity\RepositoryFactory">
  <arguments>
   <argument name="entities" xsi:type="array">
    <item name="{{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface" xsi:type="string">{{Vendor}}\{{Module}}\Api\{{Module}}RepositoryInterface</item>
   </argument>
  </arguments>
 </type>
 <type name="Magento\Framework\EntityManager\MetadataPool">
  <arguments>
   <argument name="metadata" xsi:type="array">
    <item name="{{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface" xsi:type="array">
     <item name="entityTableName" xsi:type="string">{{vendor}}_{{module}}</item>
     <item name="identifierField" xsi:type="string">{{module}}_id</item>
    </item>
   </argument>
  </arguments>
 </type>
 <type name="Magento\Framework\EntityManager\Operation\ExtensionPool">
  <arguments>
   <argument name="extensionActions" xsi:type="array">
    <item name="{{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface" xsi:type="array">
     <item name="read" xsi:type="array">
      <item name="storeReader" xsi:type="string">{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Relation\Store\ReadHandler</item>
     </item>
     <item name="create" xsi:type="array">
      <item name="storeCreator" xsi:type="string">{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Relation\Store\SaveHandler</item>
     </item>
     <item name="update" xsi:type="array">
      <item name="storeUpdater" xsi:type="string">{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\Relation\Store\SaveHandler</item>
     </item>
    </item>
   </argument>
  </arguments>
 </type>
 <type name="Magento\Framework\EntityManager\HydratorPool">
  <arguments>
   <argument name="hydrators" xsi:type="array">
    <item name="{{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface" xsi:type="string">Magento\Framework\EntityManager\AbstractModelHydrator</item>
   </argument>
  </arguments>
 </type>
 <virtualType name="{{Vendor}}\{{Module}}\Model\Api\SearchCriteria\CollectionProcessor\{{Module}}FilterProcessor" type="Magento\Framework\Api\SearchCriteria\CollectionProcessor\FilterProcessor">
  <arguments>
   <argument name="customFilters" xsi:type="array">
    <item name="store_id" xsi:type="object">{{Vendor}}\{{Module}}\Model\Api\SearchCriteria\CollectionProcessor\FilterProcessor\{{Module}}StoreFilter</item>
   </argument>
  </arguments>
 </virtualType>
 <virtualType name="{{Vendor}}\{{Module}}\Model\Api\SearchCriteria\{{Module}}CollectionProcessor" type="Magento\Framework\Api\SearchCriteria\CollectionProcessor">
  <arguments>
   <argument name="processors" xsi:type="array">
    <item name="filters" xsi:type="object">{{Vendor}}\{{Module}}\Model\Api\SearchCriteria\CollectionProcessor\{{Module}}FilterProcessor</item>
    <item name="sorting" xsi:type="object">Magento\Framework\Api\SearchCriteria\CollectionProcessor\SortingProcessor</item>
    <item name="pagination" xsi:type="object">Magento\Framework\Api\SearchCriteria\CollectionProcessor\PaginationProcessor</item>
   </argument>
  </arguments>
 </virtualType>
 <type name="{{Vendor}}\{{Module}}\Model\{{Module}}Repository">
  <arguments>
   <argument name="collectionProcessor" xsi:type="object">{{Vendor}}\{{Module}}\Model\Api\SearchCriteria\{{Module}}CollectionProcessor</argument>
   <argument name="hydrator" xsi:type="object">Magento\Framework\EntityManager\AbstractModelHydrator</argument>
  </arguments>
 </type>
</config>
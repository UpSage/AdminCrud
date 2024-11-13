<?xml version="1.0" encoding="UTF-8"?>

<listing xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Ui:etc/ui_configuration.xsd">

 <argument name="data" xsi:type="array">
  <item name="js_config" xsi:type="array">
   <item name="provider" xsi:type="string">{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_listing_data_source</item>
  </item>
 </argument>
 
 <settings>
  <buttons>
   <button name="add">
    <url path="*/*/new"/>
    <class>primary</class>
    <label translate="true">Add New {{Module}}</label>
   </button>
  </buttons>
  <spinner>{{vendor}}_{{module}}_columns</spinner>
  <deps>
   <dep>{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_listing_data_source</dep>
  </deps>
 </settings>
 
 <dataSource name="{{vendor}}_{{module}}_listing_data_source" component="Magento_Ui/js/grid/provider">
  <settings>
   <storageConfig>
    <param name="indexField" xsi:type="string">{{module}}_id</param>
   </storageConfig>
   <updateUrl path="mui/index/render"/>
  </settings>
  <aclResource>{{Vendor}}_{{Module}}::{{module}}</aclResource>
  <dataProvider class="{{Vendor}}\{{Module}}\Ui\Component\DataProvider" name="{{vendor}}_{{module}}_listing_data_source">
   <settings>
    <requestFieldName>id</requestFieldName>
    <primaryFieldName>{{module}}_id</primaryFieldName>
   </settings>
  </dataProvider>
 </dataSource>
 
 <listingToolbar name="listing_top">
  <settings>
   <sticky>true</sticky>
  </settings>
  <bookmark name="bookmarks"/>
  <columnsControls name="columns_controls"/>
  <filterSearch name="fulltext"/>
  <filters name="listing_filters">
   <settings>
    <templates>
     <filters>
      <select>
       <param name="template" xsi:type="string">ui/grid/filters/elements/ui-select</param>
       <param name="component" xsi:type="string">Magento_Ui/js/form/element/ui-select</param>
      </select>
     </filters>
    </templates>
   </settings>
   <filterSelect name="store_id" provider="${ $.parentName }">
    <settings>
     <captionValue>0</captionValue>
     <options class="{{Vendor}}\{{Module}}\Ui\Component\Listing\Column\{{Module}}\Options"/>
     <label translate="true">Store View</label>
     <dataScope>store_id</dataScope>
     <imports>
      <link name="visible">ns = ${ $.ns }, index = ${ $.index }:visible</link>
     </imports>
    </settings>
   </filterSelect>
  </filters>
  <massaction name="listing_massaction">
   <action name="delete">
    <settings>
     <confirm>
      <message translate="true">Are you sure you want to delete selected items?</message>
      <title translate="true">Delete items</title>
     </confirm>
     <url path="{{vendor}}/{{module}}/massDelete"/>
     <type>delete</type>
     <label translate="true">Delete</label>
    </settings>
   </action>
   <action name="edit">
    <settings>
     <callback>
      <target>editSelected</target>
      <provider>{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_columns_editor</provider>
     </callback>
     <type>edit</type>
     <label translate="true">Edit</label>
    </settings>
   </action>
  </massaction>
  <paging name="listing_paging"/>
 </listingToolbar>
 
 <columns name="{{vendor}}_{{module}}_columns">
  <settings>
   <editorConfig>
    <param name="clientConfig" xsi:type="array">
     <item name="saveUrl" xsi:type="url" path="{{vendor}}/{{module}}/inlineEdit"/>
     <item name="validateBeforeSave" xsi:type="boolean">false</item>
    </param>
    <param name="indexField" xsi:type="string">{{module}}_id</param>
    <param name="enabled" xsi:type="boolean">true</param>
    <param name="selectProvider" xsi:type="string">{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_columns.ids</param>
   </editorConfig>
   <childDefaults>
    <param name="fieldAction" xsi:type="array">
     <item name="provider" xsi:type="string">{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_listing.{{vendor}}_{{module}}_columns_editor</item>
     <item name="target" xsi:type="string">startEdit</item>
     <item name="params" xsi:type="array">
      <item name="0" xsi:type="string">${ $.$data.rowIndex }</item>
      <item name="1" xsi:type="boolean">true</item>
     </item>
    </param>
   </childDefaults>
  </settings>
  <selectionsColumn name="ids">
   <settings>
    <indexField>{{module}}_id</indexField>
   </settings>
  </selectionsColumn>
  <column name="{{module}}_id">
   <settings>
    <filter>textRange</filter>
    <label translate="true">ID</label>
    <sorting>asc</sorting>
   </settings>
  </column>
  <column name="title">
   <settings>
    <filter>text</filter>
    <editor>
     <validation>
      <rule name="required-entry" xsi:type="boolean">true</rule>
     </validation>
     <editorType>text</editorType>
    </editor>
    <label translate="true">Title</label>
   </settings>
  </column>
  <column name="identifier">
   <settings>
    <filter>text</filter>
    <editor>
     <validation>
      <rule name="required-entry" xsi:type="boolean">true</rule>
      <rule name="no-marginal-whitespace" xsi:type="boolean">true</rule>
     </validation>
     <editorType>text</editorType>
    </editor>
    <label translate="true">Identifier</label>
   </settings>
  </column>
  <column name="store_id" class="Magento\Store\Ui\Component\Listing\Column\Store">
   <settings>
    <label translate="true">Store View</label>
    <bodyTmpl>ui/grid/cells/html</bodyTmpl>
    <sortable>false</sortable>
   </settings>
  </column>
  <column name="is_active" component="Magento_Ui/js/grid/columns/select">
   <settings>
    <options class="{{Vendor}}\{{Module}}\Model\{{Module}}\Source\IsActive"/>
    <filter>select</filter>
    <editor>
     <editorType>select</editorType>
    </editor>
    <dataType>select</dataType>
    <label translate="true">Status</label>
   </settings>
  </column>
  <column name="creation_time" class="Magento\Ui\Component\Listing\Columns\Date" component="Magento_Ui/js/grid/columns/date">
   <settings>
    <filter>dateRange</filter>
    <dataType>date</dataType>
    <label translate="true">Created</label>
   </settings>
  </column>
  <column name="update_time" class="Magento\Ui\Component\Listing\Columns\Date" component="Magento_Ui/js/grid/columns/date">
   <settings>
    <filter>dateRange</filter>
    <dataType>date</dataType>
    <label translate="true">Modified</label>
   </settings>
  </column>
  <actionsColumn name="actions" class="{{Vendor}}\{{Module}}\Ui\Component\Listing\Column\{{Module}}Actions">
   <settings>
    <indexField>{{module}}_id</indexField>
   </settings>
  </actionsColumn>
 </columns>
 
</listing>
<?xml version="1.0" encoding="UTF-8"?>

<widgets xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Widget:etc/widget.xsd">
 <widget id="{{vendor}}_{{module}}_widget" class="{{Vendor}}\{{Module}}\Block\Widget\{{Module}}">
  <label translate="true">{{Module}}</label>
  <description translate="true">Contents of {{Module}}</description>
  <parameters>
   <parameter name="{{module}}_id" xsi:type="block" visible="true" required="true" sort_order="20">
    <label translate="true">{{Module}}</label>
    <block class="{{Vendor}}\{{Module}}\Block\Adminhtml\{{Module}}\Widget\Chooser">
     <data>
      <item name="button" xsi:type="array">
       <item name="open" xsi:type="string" translate="true">Select {{Module}}...</item>
      </item>
     </data>
    </block>
   </parameter>
   <parameter name="template" xsi:type="select" visible="true" required="true" sort_order="10">
    <label translate="true">Template</label>
    <options>
     <option name="default" value="widget/{{module}}/default.phtml" selected="true">
      <label translate="true">{{Module}} Default Template</label>
     </option>
    </options>
   </parameter>
  </parameters>
 </widget>
</widgets>
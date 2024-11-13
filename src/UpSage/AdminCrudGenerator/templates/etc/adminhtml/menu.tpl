<?xml version="1.0"?>

<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
 <menu>
  <add id="{{Vendor}}_{{Module}}::{{module}}" title="{{Module}}" module="{{Vendor}}_{{Module}}" sortOrder="40" parent="Magento_Backend::content_elements" action="{{vendor}}/{{module}}/index" resource="{{Vendor}}_{{Module}}::{{module}}"/>
 </menu>
</config>
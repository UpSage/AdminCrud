<?xml version="1.0"?>

<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
 <module name="{{Vendor}}_{{Module}}" >
  <sequence>
   <module name="Magento_Store"/>
   <module name="Magento_Theme"/>
   <module name="Magento_Variable"/>
  </sequence>
 </module>
</config>
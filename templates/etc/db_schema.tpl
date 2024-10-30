<?xml version="1.0"?>

<schema xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Setup/Declaration/Schema/etc/schema.xsd">

 <table name="{{vendor}}_{{module}}" resource="default" engine="innodb" comment="Upsage {{Module}} Table">
  <column xsi:type="smallint" name="{{module}}_id" unsigned="false" nullable="false" identity="true" comment="Entity ID"/>
  <column xsi:type="varchar" name="title" nullable="false" length="255" comment="{{Module}} Title"/>
  <column xsi:type="varchar" name="identifier" nullable="false" length="255" comment="{{Module}} String Identifier"/>
  <column xsi:type="mediumtext" name="content" nullable="true" comment="{{Module}} Content"/>
  <column xsi:type="timestamp" name="creation_time" on_update="false" nullable="false" default="CURRENT_TIMESTAMP" comment="{{Module}} Creation Time"/>
  <column xsi:type="timestamp" name="update_time" on_update="true" nullable="false" default="CURRENT_TIMESTAMP" comment="{{Module}} Modification Time"/>
  <column xsi:type="smallint" name="is_active" unsigned="false" nullable="false" identity="false" default="1" comment="Is {{Module}} Active"/>
  <constraint xsi:type="primary" referenceId="PRIMARY">
   <column name="{{module}}_id"/>
  </constraint>
  <index referenceId="{{VENDOR}}_{{MODULE}}_IDENTIFIER" indexType="btree">
   <column name="identifier"/>
  </index>
  <index referenceId="{{VENDOR}}_{{MODULE}}_TITLE_IDENTIFIER_CONTENT" indexType="fulltext">
   <column name="title"/>
   <column name="identifier"/>
   <column name="content"/>
  </index>
 </table>
 
 <table name="{{vendor}}_{{module}}_store" resource="default" engine="innodb" comment="Upsage {{Module}} To Store Linkage Table">
  <column xsi:type="smallint" name="{{module}}_id" unsigned="false" nullable="false" identity="false"/>
  <column xsi:type="smallint" name="store_id" unsigned="true" nullable="false" identity="false" comment="Store ID"/>
  <constraint xsi:type="primary" referenceId="PRIMARY">
   <column name="{{module}}_id"/>
   <column name="store_id"/>
  </constraint>
  <constraint xsi:type="foreign" referenceId="{{VENDOR}}_{{MODULE}}_STORE_{{MODULE}}_ID_{{VENDOR}}_{{MODULE}}_{{MODULE}}_ID" table="{{vendor}}_{{module}}_store" column="{{module}}_id" referenceTable="{{vendor}}_{{module}}" referenceColumn="{{module}}_id" onDelete="CASCADE"/>
  <constraint xsi:type="foreign" referenceId="{{VENDOR}}_{{MODULE}}_STORE_STORE_ID_STORE_STORE_ID" table="{{vendor}}_{{module}}_store" column="store_id" referenceTable="store" referenceColumn="store_id" onDelete="CASCADE"/>
  <index referenceId="{{VENDOR}}_{{MODULE}}_STORE_STORE_ID" indexType="btree">
   <column name="store_id"/>
  </index>
 </table>
 
</schema>
<?php

 namespace {{Vendor}}\{{Module}}\Block\Adminhtml\{{Module}}\Widget;
 
 class Chooser extends \Magento\Backend\Block\Widget\Grid\Extended {
    
  protected $_{{module}}Factory;
  
  protected $_collectionFactory;
  
  public function __construct(
   \Magento\Backend\Block\Template\Context $context,
   \Magento\Backend\Helper\Data $backendHelper,
   \{{Vendor}}\{{Module}}\Model\{{Module}}Factory ${{module}}Factory,
   \{{Vendor}}\{{Module}}\Model\ResourceModel\{{Module}}\CollectionFactory $collectionFactory,
   array $data = []
  ) {
   $this->_{{module}}Factory = ${{module}}Factory;
   $this->_collectionFactory = $collectionFactory;
   parent::__construct($context, $backendHelper, $data);
  }
  
  protected function _construct() {
   parent::_construct();
   $this->setDefaultSort('{{module}}_identifier');
   $this->setDefaultDir('ASC');
   $this->setUseAjax(true);
   $this->setDefaultFilter(['chooser_is_active' => '1']);
  }
  
  public function prepareElementHtml(\Magento\Framework\Data\Form\Element\AbstractElement $element) {
   $uniqId = $this->mathRandom->getUniqueHash($element->getId());
   $sourceUrl = $this->getUrl('{{vendor}}/{{module}}_widget/chooser', ['uniq_id' => $uniqId]);
   $chooser = $this->getLayout()->createBlock(
    \Magento\Widget\Block\Adminhtml\Widget\Chooser::class
   )->setElement(
    $element
   )->setConfig(
    $this->getConfig()
   )->setFieldsetId(
    $this->getFieldsetId()
   )->setSourceUrl(
    $sourceUrl
   )->setUniqId(
    $uniqId
   );
   
   if($element->getValue()) {
    ${{module}} = $this->_{{module}}Factory->create()->load($element->getValue());
    if(${{module}}->getId()) {
     $chooser->setLabel($this->escapeHtml(${{module}}->getTitle()));
    }
   }
   
   $element->setData('after_element_html', $chooser->toHtml());
   return $element;
  }
  
  public function getRowClickCallback() {
   $chooserJsObject = $this->getId();
   $js = '
    function (grid, event) {
     var trElement = Event.findElement(event, "tr");
     var {{module}}Id = trElement.down("td").innerHTML.replace(/^\s+|\s+$/g,"");
     var {{module}}Title = trElement.down("td").next().innerHTML;' .
     $chooserJsObject . '.setElementValue({{module}}Id); ' .
     $chooserJsObject . '.setElementLabel({{module}}Title); ' .
     $chooserJsObject . '.close();
    }
   ';
   return $js;
  }
  
  protected function _prepareCollection() {
   $this->setCollection($this->_collectionFactory->create());
   return parent::_prepareCollection();
  }
  
  protected function _prepareColumns() {
    
   $this->addColumn(
    'chooser_id',
    ['header' => __('ID'), 'align' => 'right', 'index' => '{{module}}_id', 'width' => 50]
   );
   
   $this->addColumn('chooser_title', ['header' => __('Title'), 'align' => 'left', 'index' => 'title']);
   
   $this->addColumn(
    'chooser_identifier',
    ['header' => __('Identifier'), 'align' => 'left', 'index' => 'identifier']
   );
   
   $this->addColumn(
    'chooser_is_active',
    [
     'header' => __('Status'),
     'index' => 'is_active',
     'type' => 'options',
     'options' => [0 => __('Disabled'), 1 => __('Enabled')]
    ]
   );
   
   return parent::_prepareColumns();

  }
  
  public function getGridUrl() {
   return $this->getUrl('{{vendor}}/{{module}}_widget/chooser', ['_current' => true]);
  }

 }

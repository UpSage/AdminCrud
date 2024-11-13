<?php

 namespace {{Vendor}}\{{Module}}\Ui\Component\Listing\Column;
 
 use Magento\Framework\UrlInterface;
 use Magento\Framework\View\Element\UiComponent\ContextInterface;
 use Magento\Framework\View\Element\UiComponentFactory;
 use Magento\Ui\Component\Listing\Columns\Column;
 use Magento\Framework\App\ObjectManager;
 use Magento\Framework\Escaper;
 
 class {{Module}}Actions extends Column {
    
  public const URL_PATH_EDIT = '{{vendor}}/{{module}}/edit';
  public const URL_PATH_DELETE = '{{vendor}}/{{module}}/delete';
  public const URL_PATH_DETAILS = '{{vendor}}/{{module}}/details';
  
  protected $urlBuilder;
  
  private $escaper;
  
  public function __construct(
   ContextInterface $context,
   UiComponentFactory $uiComponentFactory,
   UrlInterface $urlBuilder,
   array $components = [],
   array $data = []
  ) {
   $this->urlBuilder = $urlBuilder;
   parent::__construct($context, $uiComponentFactory, $components, $data);
  }
  
  public function prepareDataSource(array $dataSource) {
   if(isset($dataSource['data']['items'])) {
    foreach ($dataSource['data']['items'] as & $item) {
     if(isset($item['{{module}}_id'])) {
      $title = $this->getEscaper()->escapeHtmlAttr($item['title']);
      $item[$this->getData('name')] = [
       'edit' => [
        'href' => $this->urlBuilder->getUrl(static::URL_PATH_EDIT,['{{module}}_id' => $item['{{module}}_id']]),
        'label' => __('Edit')
       ],
       'delete' => [
        'href' => $this->urlBuilder->getUrl(static::URL_PATH_DELETE,['{{module}}_id' => $item['{{module}}_id']]),
        'label' => __('Delete'),
        'confirm' => [
         'title' => __('Delete %1', $title),
         'message' => __('Are you sure you want to delete a %1 record?', $title)
        ],
        'post' => true
       ],
      ];
     }
    }
   }
   return $dataSource;
  }
  
  private function getEscaper() {
   if(!$this->escaper) {
    $this->escaper = ObjectManager::getInstance()->get(Escaper::class);
   }
   return $this->escaper;
  }

}
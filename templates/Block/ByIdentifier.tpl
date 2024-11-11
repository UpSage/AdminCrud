<?php

 declare(strict_types=1);
 
 namespace {{Vendor}}\{{Module}}\Block;
 
 use {{Vendor}}\{{Module}}\Api\Data\{{Module}}Interface;
 use {{Vendor}}\{{Module}}\Api\Get{{Module}}ByIdentifierInterface;
 use {{Vendor}}\{{Module}}\Model\{{Module}} as {{Module}}Model;
 use {{Vendor}}\{{Module}}\Model\Template\FilterProvider;
 use Magento\Framework\DataObject\IdentityInterface;
 use Magento\Framework\Exception\NoSuchEntityException;
 use Magento\Framework\View\Element\AbstractBlock;
 use Magento\Framework\View\Element\Context;
 use Magento\Store\Model\StoreManagerInterface;
 
 class {{Module}}ByIdentifier extends AbstractBlock implements IdentityInterface {
    
  public const CACHE_KEY_PREFIX = '{{MODULE}}';
  
  private ${{module}}ByIdentifier;
  
  private $storeManager;
  
  private $filterProvider;
  
  private ${{module}};
  
  public function __construct(
   Get{{Module}}ByIdentifierInterface ${{module}}ByIdentifier,
   StoreManagerInterface $storeManager,
   FilterProvider $filterProvider,
   Context $context,
   array $data = []
  ) {
   parent::__construct($context, $data);
   $this->{{module}}ByIdentifier = ${{module}}ByIdentifier;
   $this->storeManager = $storeManager;
   $this->filterProvider = $filterProvider;
  }
  
  protected function _toHtml(): string {
   try {
    return $this->filterOutput(
     $this->get{{Module}}()->getContent()
    );
   } catch (NoSuchEntityException $e) {
    return '';
   }
  }
  
  private function getIdentifier(): ?string {
   return $this->getData('identifier') ?: null;
  }
  
  private function filterOutput(string $content): string {
   return $this->filterProvider->get{{Module}}Filter()->setStoreId($this->getCurrentStoreId())->filter($content);
  }
  
  private function get{{Module}}(): {{Module}}Interface {
   if(!$this->getIdentifier()) {
    throw new \InvalidArgumentException('Expected value of `identifier` was not provided');
   }
   if(null === $this->{{module}}) {
    $this->{{module}} = $this->{{module}}ByIdentifier->execute(
     (string)$this->getIdentifier(),
     $this->getCurrentStoreId()
    );
    if(!$this->{{module}}->isActive()) {
     throw new NoSuchEntityException(
      __('The {{module}} with identifier "%identifier" is not enabled.', $this->getIdentifier())
     );
    }
   }
   return $this->{{module}};
  }
  
  private function getCurrentStoreId(): int {
   return (int)$this->storeManager->getStore()->getId();
  }
  
  public function getIdentities(): array {
   if(!$this->getIdentifier()) {
    return [];
   }
   $identities = [
    self::CACHE_KEY_PREFIX . '_' . $this->getIdentifier(),
    self::CACHE_KEY_PREFIX . '_' . $this->getIdentifier() . '_' . $this->getCurrentStoreId()
   ];
   try {
    ${{module}} = $this->get{{Module}}();
    if(${{module}} instanceof IdentityInterface) {
     $identities = array_merge($identities, ${{module}}->getIdentities());
    }
   } catch (NoSuchEntityException $e) {}
   
   return $identities;
  }

 }

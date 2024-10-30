<?php

 namespace UpSage\AdminCrud\Console\Command;
 
 use Magento\Framework\Console\Cli;
 use Magento\Framework\Exception\LocalizedException;
 use Symfony\Component\Console\Command\Command;
 use Symfony\Component\Console\Input\InputArgument;
 use Symfony\Component\Console\Input\InputInterface;
 use Symfony\Component\Console\Output\OutputInterface;
 use Symfony\Component\Filesystem\Filesystem;
 use Symfony\Component\Filesystem\Exception\IOExceptionInterface;
 
 class CreateModuleCommand extends Command {
    
  const ARG_VENDOR = 'vendor';
  const ARG_MODULE = 'module';
  
  protected Filesystem $filesystem;
  
  public function __construct(Filesystem $filesystem) {
   $this->filesystem = $filesystem;
   parent::__construct();
  }
  
  protected function configure() {
   $this->setName('upsage:admincrud:create')
    ->setDescription('Creates a new Magento 2 module structure')
    ->addArgument(self::ARG_VENDOR, InputArgument::REQUIRED, 'Vendor Name')
    ->addArgument(self::ARG_MODULE, InputArgument::REQUIRED, 'Module Name');
  }
  
  protected function execute(InputInterface $input, OutputInterface $output) {
   $vendor = $input->getArgument(self::ARG_VENDOR);
   $module = $input->getArgument(self::ARG_MODULE);
   $baseDir = BP . "/app/code/{$vendor}/{$module}/";
   $templatesDir = BP . '/app/code/UpSage/AdminCrud/templates/';
   $vendorLC = strtolower($vendor);
   $moduleLC = strtolower($module);
   $vendorUC = strtoupper($vendor);
   $moduleUC = strtoupper($module);

   if(is_dir($baseDir)) {
    $output->writeln("<error>Module directory {$baseDir} already exists. Aborting.</error>");
    return Cli::RETURN_FAILURE;
   }
   
   $fileMappings = [
    "registration.php" => "registration.tpl",
    "etc/acl.xml" => "etc/acl.tpl",
    "etc/db_schema.xml" => "etc/db_schema.tpl",
    "etc/di.xml" => "etc/di.tpl",
    "etc/module.xml" => "etc/module.tpl",
    "etc/widget.xml" => "etc/widget.tpl",
    "etc/adminhtml/menu.xml" => "etc/adminhtml/menu.tpl",
    "etc/adminhtml/routes.xml" => "etc/adminhtml/routes.tpl",
    "Api/{$module}RepositoryInterface.php" => "Api/RepositoryInterface.tpl",
    "Api/Get{$module}ByIdentifierInterface.php" => "Api/GetByIdentifierInterface.tpl",
    "Api/Data/{$module}Interface.php" => "Api/Data/Interface.tpl",
    "Api/Data/{$module}SearchResultsInterface.php" => "Api/Data/SearchResultsInterface.tpl",
   ];
   
   try{
    foreach ($fileMappings as $filePath => $templateFile) {
     $fullPath = $baseDir . $filePath;
     $templateFilePath = $templatesDir . $templateFile;
     if(!file_exists($templateFilePath)) {
      $output->writeln("<error>Template file {$templateFilePath} not found. Aborting.</error>");
      return Cli::RETURN_FAILURE;
     }
     $templateContent = file_get_contents($templateFilePath);
     $content = str_replace(
      ['{{Vendor}}', '{{Module}}', '{{vendor}}', '{{module}}', '{{VENDOR}}', '{{MODULE}}'],
      [$vendor, $module, $vendorLC, $moduleLC, $vendorUC, $moduleUC],
      $templateContent
     );
     $this->createFile($fullPath, $content);
     $output->writeln("<info>Created: {$fullPath}</info>");
    }
    $output->writeln('<info>Module structure created successfully.</info>');
    return Cli::RETURN_SUCCESS;
   } catch (IOExceptionInterface $e) {
    $output->writeln("<error>Could not create directory at {$e->getPath()}</error>");
    return Cli::RETURN_FAILURE;
   } catch (LocalizedException $e) {
    $output->writeln("<error>{$e->getMessage()}</error>");
    return Cli::RETURN_FAILURE;
   }
  }
  
  protected function createFile($filePath, $content) {
   if(!is_dir(dirname($filePath))) {
    $this->filesystem->mkdir(dirname($filePath), 0777);
   }
   $this->filesystem->dumpFile($filePath, $content);
  }

 }

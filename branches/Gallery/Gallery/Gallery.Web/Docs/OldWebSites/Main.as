package{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import ro.fwd.DataModel;
	import ro.fwd.ImageScreen;
	import ro.fwd.ThumbsController;
	import ro.fwd.LoadBar;
	import ro.fwd.utils.FullScreenMenu;
	
	public class Main extends Sprite{
		/*
		THIS CLASS IS THE MAIN CLASS IS INSTANTIATING  THE GALLERY CLASSES AND ADDING THE FUNCTIONALITY
		*/
		private var _dataModel:DataModel;//holds a reference to the DataModel instance
		private var _imageScreen:ImageScreen;//holds a reference to the ImageScreen instance
		private var _thumbsController:ThumbsController;//holds a reference to the thumbs displayObject
		private var _loadBar:LoadBar;//this is the animated round circle used to show a loader when th image is still loading
		private var _contextMenu:FullScreenMenu//holds a reference to FullScreenMenu
		
		//constructor
		public function Main(){
			//preparing the stage 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//instantiate the DataModel and adding an update INIT even UPDATE  event
			_dataModel =  new DataModel("load/images.xml");
			_dataModel.addEventListener(DataModel.INIT, initGallery);
			_dataModel.addEventListener(DataModel.UPDATE, updateGallery);
		}
		
		//this function instantiates all the clasees needed 
		private function initGallery(e:Event):void{
			_contextMenu = new FullScreenMenu(this);
			_imageScreen =  new ImageScreen();
			_loadBar =  new LoadBar(_imageScreen);
			addChildAt(_imageScreen,0);
			_imageScreen.createImage(_dataModel.getBigImage(_dataModel.curId));
			_imageScreen.addEventListener(ImageScreen.FIRST_IMAGE_LOADED_DONE, initControls);
			_thumbsController = new ThumbsController(_dataModel,_imageScreen);
			addChild(_thumbsController);
			addChild(_loadBar);
			
		}
		
		//creates and load the first image
		private function initControls(e:Event):void{
			trace("INIT COTROL");
			_thumbsController.animateThisOnIntro();
		}
		
		//creates and load an image everytime the DataModel changes
		private function updateGallery(e:Event):void{
			trace("UPDATING")
			_imageScreen.createImage(_dataModel.getBigImage(_dataModel.curId));
		}
	}
}
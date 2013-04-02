package com.esri.viewer.utils
{

import com.esri.ags.SpatialReference;
import com.esri.ags.geometry.Extent;
import com.esri.ags.geometry.MapPoint;
import com.esri.ags.layers.TiledMapServiceLayer;
import com.esri.ags.layers.supportClasses.LOD;
import com.esri.ags.layers.supportClasses.TileInfo;

import flash.net.URLRequest;


/**
 * PortlandTiledMapServiceLayer   
 */
public class CostumTiledMapServiceLayer extends TiledMapServiceLayer
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     * Creates a new PortlandTiledMapServiceLayer object.
     */
    public function CostumTiledMapServiceLayer(url:String)
    {
        super();
		if(url==null || url =="") return;
		_baseURL = url;
		
        buildTileInfo(); // to create our hardcoded tileInfo

        setLoaded(true); // Map will only use loaded layers
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _tileInfo:TileInfo = new TileInfo(); // see buildTileInfo()
    //private var _baseURL:String = "http://10.23.108.71:8088/gzwater/GhcWater/Layers/_alllayers";
    //private var _baseURL:String = "http://10.23.108.71:8088/gzwater/Ghc_10_fblwp/Layers/_alllayers";
//    private var _baseURL:String = "http://10.23.108.71:8088/gzwater/Ghc120326dxt/Layers/_alllayers";
    private var _baseURL:String = "http://10.23.108.71:8088/gzwater/slsjzx110303allyxt/Layers/_alllayers";

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //      fullExtent()
    //      initialExtent()
    //      spatialReference()
    //      tileInfo()
    //      units()
    //
    //--------------------------------------------------------------------------


    //----------------------------------
    //  fullExtent
    //  - required to calculate the tiles to use
    //----------------------------------

    override public function get fullExtent():Extent
    {
        return new Extent(393110.141295908,2499093.10775215,505375.711512128,2648263.33230556, new SpatialReference(2383));
    }

    //----------------------------------
    //  initialExtent
    //  - needed if Map doesn't have an extent
    //----------------------------------

    override public function get initialExtent():Extent
    {
        return new Extent(393110.141295908,2499093.10775215,505375.711512128,2648263.33230556, new SpatialReference(2383));
    }

    //----------------------------------
    //  spatialReference
    //  - needed if Map doesn't have a spatialReference
    //----------------------------------

    override public function get spatialReference():SpatialReference
    {
        return new SpatialReference(2383);
    }

    //----------------------------------
    //  tileInfo
    //----------------------------------

    override public function get tileInfo():TileInfo
    {
        return _tileInfo;
    }

    //----------------------------------
    //  units
    //  - needed if Map doesn't have it set
    //----------------------------------

//    override public function get units():String
//    {
//        return com.esri.ags.Units.METERS;
//    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //      getTileURL(level:Number, row:Number, col:Number):URLRequest
    //
    //--------------------------------------------------------------------------

    override protected function getTileURL(level:Number, row:Number, col:Number):URLRequest
    {
        // Use virtual cache directory
        // This assumes the cache's virtual directory is exposed, which allows you access
        // to tile from the Web server via the public cache directory.
        // Example of a URL for a tile retrieved from the virtual cache directory:
        // http://serverx.esri.com/arcgiscache/dgaerials/Layers/_alllayers/L01/R0000051f/C000004e4.jpg
        var url:String = _baseURL
            + "/L" + padString(String(level), 2, "0")
            + "/R" + padString(row.toString(16), 8, "0")
            + "/C" + padString(col.toString(16), 8, "0") + ".png";
        return new URLRequest(url);
    }

    //--------------------------------------------------------------------------
    //
    //  Private Methods
    //
    //--------------------------------------------------------------------------

    private function buildTileInfo():void
    {
        _tileInfo.height = 512;
        _tileInfo.width = 512;
        _tileInfo.origin = new MapPoint(-5123200,10002100);
        _tileInfo.spatialReference = new SpatialReference(2383,'PROJCS["Xian_1980_3_Degree_GK_CM_114E",GEOGCS["GCS_Xian_1980",DATUM["D_Xian_1980",SPHEROID["Xian_1980",6378140.0,298.257]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Gauss_Kruger"],PARAMETER["False_Easting",500000.0],PARAMETER["False_Northing",0.0],PARAMETER["Central_Meridian",114.0],PARAMETER["Scale_Factor",1.0],PARAMETER["Latitude_Of_Origin",0.0],UNIT["Meter",1.0],AUTHORITY["EPSG",2383]]');
		//Alert.show("-5123200,10002100");
        _tileInfo.lods =
            [
            new LOD(0, 264.583862501058, 1000000),
            new LOD(1, 132.291931250529, 500000),
            new LOD(2, 66.1459656252646, 250000),
            new LOD(3, 26.4583862501058, 100000),
            new LOD(4, 13.2291931250529, 50000),
            new LOD(5, 6.61459656252646, 25000),
            new LOD(6, 2.64583862501058, 10000),
            new LOD(7, 1.32291931250529, 5000),
            new LOD(8, 0.529167725002117, 2000),
            new LOD(9, 0.264583862501058, 1000),
            new LOD(10, 0.132291931250529, 500)
//            new LOD(13, 0.0000429153442382813, 18035.7421002707),
//            new LOD(14, 0.0000214576721191406, 9017.87105013534),
//            new LOD(15, 0.0000107288360595703, 4508.93552506767)
            ];
    }

    private function padString(text:String, size:int, ch:String):String
    {
        while (text.length < size)
        {
            text = ch + text;
        }
        return text;
    }
}

}

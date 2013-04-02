package com.esri.viewer.components.chart
{
	import com.amcharts.AmPieChart;

	public class PieCharts extends AmPieChart
	{
		public function PieCharts() 
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			if(this._amchartsLink)
			{
				this._amchartsLink.visible=false;
				this._amchartsLink.width =0;
				this._amchartsLink.height =0;
				this._amchartsLink.alpha=0;
			}
		}
	}
}
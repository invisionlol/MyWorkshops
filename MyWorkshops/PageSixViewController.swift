//
//  PageSixViewController.swift
//  MyWorkshops
//
//  Created by INVISION on 17/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit
import Charts

class PageSixViewController: UIViewController {
    
    @IBOutlet weak var mLineChartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createLineChart()

    }
    
    func createLineChart (){
        
        // Chart Configure
        self.mLineChartView.chartDescription?.text = "Codemobiles"
        self.mLineChartView.setExtraOffsets(left: 0, top: 0, right: 30, bottom: 0)
        
        self.mLineChartView.chartDescription?.font = UIFont.boldSystemFont(ofSize: 15)
        self.mLineChartView.xAxis.labelPosition = .bottom
        self.mLineChartView.leftAxis.enabled = true;
        self.mLineChartView.rightAxis.enabled = false;
        
        // Set colors
        self.view.backgroundColor = UIColor(hexString: "#252934")
        self.mLineChartView.chartDescription?.textColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.9)
        self.mLineChartView.leftAxis.labelTextColor =  UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        self.mLineChartView.leftAxis.gridColor =  UIColor(hexString: "#FFFFFF").withAlphaComponent(0.1)
        self.mLineChartView.legend.textColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        self.mLineChartView.xAxis.gridColor =  UIColor(hexString: "#9d9272").withAlphaComponent(0.1)
        self.mLineChartView.xAxis.labelTextColor = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        self.mLineChartView.backgroundColor = UIColor.clear
        self.mLineChartView.gridBackgroundColor = UIColor.clear
        
        
        
        
        let rawData = [18500.0, 18550.0, 18650.0, 18650.0, 19005.0, 18650.0, 18550.0]
        var dataEntry: [ChartDataEntry] = []
        
        for i in 0...rawData.count-1 {
            dataEntry.append(ChartDataEntry(x: Double(i) , y: rawData[i]))
        }
        
        // Graphic configure
        let dataSet = LineChartDataSet(entries: dataEntry, label: "GOLD")
        
        
        dataSet.valueFont = UIFont.boldSystemFont(ofSize: 14)
        dataSet.valueFormatter = ValueFormatter()
        
        
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = UIColor(hexString: "#6D95E8")
        dataSet.fillAlpha = 0.3
        dataSet.lineWidth = 4
        dataSet.mode = .cubicBezier
        dataSet.circleRadius = 10
        dataSet.circleHoleRadius = 7
        dataSet.colors = [UIColor(hexString: "#3FB4FC")]
        dataSet.setCircleColor(UIColor(hexString: "#252934"))
        dataSet.valueColors = [UIColor(hexString: "#FFFFFF")]
        dataSet.circleHoleColor = UIColor(hexString: "#3FB4FC");
        
        let chartData = LineChartData()
        chartData.addDataSet(dataSet)
        self.mLineChartView.data = chartData
    }
    
    @objc(ValueFormatter)
    public class ValueFormatter: NSObject, IValueFormatter{
        
        public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            return String(format: "%.0f", locale: Locale.current, Double(value))
        }
    }

   

}

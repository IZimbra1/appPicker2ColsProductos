//
//  ViewController.h
//  appPicker2ColsProductos
//
//  Created by Guest User on 22/10/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *label1;


@property (weak, nonatomic) IBOutlet UIImageView *imageView1;


@property (weak, nonatomic) IBOutlet UIPickerView *pickerView1;


@property (weak, nonatomic) IBOutlet UILabel *labelPrecioContado;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentMeses;

@property (weak, nonatomic) IBOutlet UILabel *labelPrecioFinal;

@end


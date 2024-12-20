
//
//  ViewController.m
//  appPicker2ColsProductos
//
//  Created by Guest User on 22/10/24.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *productos;
    NSArray *colores;
    NSArray *precios;    // Array para los precios al contado de los productos
    NSArray *imagenes;   // Array para los nombres de las imágenes
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Inicialización de los productos, colores y precios
    productos = @[@"Pantalla LCD", @"iPad", @"Bicicleta", @"Motocicleta", @"Carro", @"Camioneta"];
    colores = @[@"Rojo🦐", @"Verde🐍", @"Azul🐬", @"Gris🐭", @"Naranja🐅", @"Aleatorio"];
    precios = @[@1000, @1500, @300, @5000, @20000, @25000];
    imagenes = @[@"PantallaLCD", @"ipad", @"BICI_2", @"moto1", @"ferrari1", @"camioneta1"];
    
    self.pickerView1.delegate = self;
    self.pickerView1.dataSource = self;
    
    // Establece el texto inicial de la etiqueta
    self.label1.text = [NSString stringWithFormat:@"%@, %@", productos[0], colores[0]];
    
    // Inicializa la imagen
    self.imageView1.image = [UIImage imageNamed:imagenes[0]];
    
   
    
    // Actualiza el precio inicial
    [self actualizarPrecioContado];
    [self actualizarPrecioFinal];  // Asegura que el precio final también se actualiza al iniciar
}

// Métodos del UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return productos.count;
    } else {
        return colores.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return productos[row];
    } else {
        return colores[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger productoIndex = [pickerView selectedRowInComponent:0];
    NSInteger colorIndex = [pickerView selectedRowInComponent:1];
    
    // Actualiza el texto de la etiqueta
    self.label1.text = [NSString stringWithFormat:@"%@, %@", productos[productoIndex], colores[colorIndex]];
    
    // Cambia el fondo de la imagen y el fondo de la vista principal
    [self cambiarColorDeFondo:colorIndex];
    
    // Cambia la imagen de acuerdo al producto seleccionado
    [self cambiarImagenDeProducto:productoIndex];
    
    // Actualiza el precio al contado
    [self actualizarPrecioContado];
    
    // Actualiza el precio final tras cada selección de producto o color
    [self actualizarPrecioFinal];
}


// Cambiar color de fondo según el color seleccionado
- (void)cambiarColorDeFondo:(NSInteger)colorIndex {
    UIColor *nuevoColor;
    switch (colorIndex) {
        case 0: nuevoColor = [UIColor redColor]; break;
        case 1: nuevoColor = [UIColor greenColor]; break;
        case 2: nuevoColor = [UIColor blueColor]; break;
        case 3: nuevoColor = [UIColor grayColor]; break;
        case 4: nuevoColor = [UIColor orangeColor]; break;
        case 5: { // Color aleatorio
            srand((unsigned int)time(NULL));
            CGFloat red = rand() % 256 / 255.0;
            CGFloat green = rand() % 256 / 255.0;
            CGFloat blue = rand() % 256 / 255.0;
            nuevoColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            break;
        }
        default: nuevoColor = [UIColor whiteColor]; break;
    }
    
    // Cambiar el color de fondo de la imagen
    self.imageView1.backgroundColor = nuevoColor;
    
    // Cambiar el color de fondo de la vista principal
    self.view.backgroundColor = nuevoColor;
    
    NSLog(@"Color seleccionado: %ld, Color generado: %@", (long)colorIndex, nuevoColor);
}


// Cambiar imagen de producto
- (void)cambiarImagenDeProducto:(NSInteger)productoIndex {
    self.imageView1.image = [UIImage imageNamed:imagenes[productoIndex]];
}

// Actualizar el precio al contado
- (void)actualizarPrecioContado {
    NSInteger productoSeleccionado = [self.pickerView1 selectedRowInComponent:0];
    self.labelPrecioContado.text = [NSString stringWithFormat:@"$%.2f", [precios[productoSeleccionado] floatValue]];
}

// Actualizar el precio final
- (void)actualizarPrecioFinal {
    NSInteger productoSeleccionado = [self.pickerView1 selectedRowInComponent:0];
    float precioContado = [precios[productoSeleccionado] floatValue];
    
    // Obtén el número de meses basado en la selección del UISegmentedControl
    NSInteger meses = 0;
    switch (self.segmentMeses.selectedSegmentIndex) {
        case 0: meses = 12; break;
        case 1: meses = 24; break;
        case 2: meses = 36; break;
        case 3: meses = 48; break;
        case 4: meses = 60; break;
    }
    
    // Aplica un incremento de interés por mes
    float precioFinal = precioContado * (1 + 0.05 * meses / 12);  // 5% adicional por cada 12 meses
    
    // Actualiza el label del precio final
    self.labelPrecioFinal.text = [NSString stringWithFormat:@"$%.2f", precioFinal];
}

// Acción del UISegmentedControl
- (IBAction)segmentoMesesCambiado:(UISegmentedControl *)sender {
    // Asegúrate de que el valor del segmento esté correctamente interpretado
    // Actualiza el precio final cuando el usuario cambie el número de meses
    [self actualizarPrecioFinal];
}
@end

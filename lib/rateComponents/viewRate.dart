import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';

class viewRate extends StatefulWidget {
  final Cpu cpu;
  final Psu psu;
  final Motherboard mtb;
  final Drive drive;
  final Ram ram;
  final Case cases;
  final Gpu gpu;
  final Cooler cooler;
  final String code;
  final List<Drive> extradisk;
  final double minTdp, maxTdp, ramNumber;
  
  viewRate({
    this.cpu,
    this.psu,
    this.mtb,
    this.drive,
    this.ram,
    this.cases,
    this.gpu,
    this.cooler,
    this.code,
    this.extradisk,
    this.minTdp,
    this.maxTdp,
    this.ramNumber,
  });

  @override
  _viewRateState createState() => _viewRateState();
}

class _viewRateState extends State<viewRate> {
  DateTime now = new DateTime(DateTime.now().year);
  TextStyle style = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontFamily: GoogleFonts.workSans().fontFamily,
  );
  int rand(min, max) {
    var rand = new Random();
    return min + rand.nextInt(max - min) + 1;
  }
  @override
  initState() {
    super.initState();
    print(widget.extradisk.length);
    print(widget.maxTdp);
    print(widget.ramNumber);

  }
  Widget buildItems() {
    List<String> compList = [
      widget.cpu.model,
      widget.gpu.model,
      widget.ram.model,
      widget.psu.model,
      widget.drive.model,
      widget.mtb.model,
      widget.cases.model,
    ];
    List<String> typeList = [
      'Procesor: ',
      'Karta graficzna: ',
      'Ram: ',
      'Zasilacz: ',
      'Dysk systemowy: ',
      'Płyta główna: ',
      'Obudowa: ',
    ];
    List<String> cpuStartString = [
      'Wybrany procesor ',
      'Ten model procesora ',
      'Twój procesor ',
    ];


    //////////////////////////////// Zdania procesora
    String cpuString = '';
    if (int.parse(now.toString().substring(0, 3)) - int.parse(widget.cpu.year) >
        4)
      cpuString += cpuStartString[rand(0, 2)] +
          "ma już ponad 4 lata, więc może nie radzić sobie tak samo dobrze, jak nowsze modele firmy " +
          widget.cpu.manufacturer +
          ". ";
    else
      cpuString += cpuStartString[rand(0, 2)] +
          "jest dosyć nowym modelem, więc bez problemu powinien poradzić sobie w codziennym użytkowaniu. ";

    if (int.parse(widget.cpu.cores) < 4) {
      String rdzeniuw = ' rdzeni. ';
      if (int.parse(widget.cpu.cores) < 2) rdzeniuw = ' rdzeń. ';
      cpuString += cpuStartString[rand(0, 2)] +
          'posiada także tylko ' +
          widget.cpu.cores +
          rdzeniuw +
          'Może to powodować wolniejsze działanie nowszych aplikacji, przystosowanych do wykorzystywania wielu rdzeni. ';
    } else
      cpuString += cpuStartString[rand(0, 2)] +
          'posiada aż ' +
          widget.cpu.cores +
          ' rdzeni, dzięki czemu można liczyć na świetne wyniki procesora w wymagających programach. ';

    if (widget.cpu.isUnlocked && double.parse(widget.cpu.clocker) < 2.5)
      cpuString += 'Pomimo że procesor posiada małą wartość zegara, ' +
          widget.cpu.clocker +
          ' GHz' +
          ', to jest on odblokowany, a to zapewnia możliwość zwiększenia tego parametru. ';
    else if (!widget.cpu.isUnlocked && double.parse(widget.cpu.clocker) < 2.5)
      cpuString += 'Procesor posiada małą wartość zegara, ' +
          widget.cpu.clocker +
          ' GHz' +
          ', a w dodatku ma on zablokowany mnożnik, co usuwa możliwość zwiększenia tego parametru. ';
    else if (!widget.cpu.isUnlocked && double.parse(widget.cpu.clocker) >= 2.5)
      cpuString += 'Procesor posiada wartość zegara ' +
          widget.cpu.clocker +
          ' GHz' +
          ', ale ma zablokowany mnożnik, co uniemożliwia potencjalne zwiększenie tego parametru. ';
    else if (widget.cpu.isUnlocked && double.parse(widget.cpu.clocker) >= 2.5)
      cpuString += 'Procesor posiada wartość zegara ' +
          widget.cpu.clocker +
          ' GHz' +
          ', ale ma też odblokowany mnożnik, co pozwala na zwiększenie tego parametru. ';

  //////////////////////////////// Zdania płyty głównej
  String mtbString = '';
    if(int.parse(widget.mtb.ethernetSpeed.toString())<200){
      mtbString+='Port ethernetowy w płycie głównej jest niskiej prędkości, bo osiąga tylko ' +widget.mtb.ethernetSpeed+' mb/s. Może to być problem przy podpięciu się do sieci swiatłowodowej. ';
      if(widget.mtb.wifi)mtbString+='Komensuje to jednak fakt, że w wybraną płyte główną, wbudowany jest moduł Wi-Fi. ';
    }
    else {
      mtbString+=' Port ethernetowy w płycie głównej powinien poradzić sobie z przepustowością większości łącz, ponieważ osiąga on '+widget.mtb.ethernetSpeed+ ' mb/s. ';
      if(widget.mtb.wifi)mtbString+='Problemem nie będzie też podpięcie komputera do sieci bezprzewodowej, ponieważ płyta wyposażona jest w moduł Wi-Fi. ';
    }

    if(int.parse(widget.mtb.ramSlots)<=2) mtbString+='Płyta, posiadając tylko '+widget.mtb.ramSlots+ ' miejsca na kości ramu, nie oferuje zbyt dużej opcji rozbudowy. ';
    else  mtbString+= 'Płyta, posiadając '+widget.mtb.ramSlots+ ' miejsca na kości ramu, pozwala na ewentualną rozbudowe systemu. ';

    if(int.parse(widget.mtb.usb3)>4) mtbString+='Warto dodać, że na płycie możemy znaleźć ' +widget.mtb.usb3+' portów USB 3.0, co umożliwi na podłączenie urządzeń wymagających dużej przepustowości danych. ';
    else if(int.parse(widget.mtb.usb3)>0) mtbString+='Warto dodać, że na płycie możemy znaleźć ' +widget.mtb.usb3+' porty USB 3.0, co umożliwi na podłączenie urządzeń wymagających dużej przepustowości danych. ';
    else mtbString+= 'Niestety, płyta nie posiada żadnych portów USB 3.0, więc podłączenie niektórych urządeń do komputera, może być problematyczne.';
    //////////////////////////// Zdania karty graficznej
    String gpuString='';
    if(widget.gpu.integra)gpuString+='System nie posiada dedykowanej karty graficznej, przez co system może sobie nie radzić sobie z zaawansowanymi obliczeniami 3D. Trudne może być granie w bardziej wymagające gry, a także praca nad obróbką obrazów lub wideo.';
    else{
      gpuString+="System posiada dedykowaną kartę graficzną firmy "+widget.gpu.manufacturer+', wyposażoną w '+widget.gpu.VRAM+'GB pamięci. ';
      if(int.parse(widget.gpu.VRAM)<4) gpuString+='Może to być niestety niewystarczająco na dzisiejsze standardy. Często gry i programy graficzne zalecają posiadanie minimum 4GB VRAMU. ';
      else gpuString+='Powinno to być wystarczająco dużo, dla użyć graficznych i growych. ';
      if (int.parse(now.toString().substring(0, 3)) - int.parse(widget.gpu.year) > 4) gpuString+='Karta jest niestety starsza niż 4 lata, przez co odstawać może pod kątem obliczeniowym, od nowszych modeli dostępnych na rynku';
      else gpuString+='Karta została wydana w '+widget.gpu.year+' roku, więc wsparcie techniczne oraz sterowniki powinny być aktualne. ';
    }
    ///////////////////////Zdania ramu
    String ramString='';
    if(widget.ram.type=='DDR4'){
      if(int.parse(widget.ram.speed)<3200)ramString+='Wybrane kości ramu firmy '+widget.ram.manufacturer +' nie są wyborem najbardziej optymalnym, ponieważ ich prękość zegaru wyosni'
      +widget.ram.speed+' MHz. W przypadku kości DDR4, optymalną prędkością jest 3200 MHz. ';
      else ramString+='Wybrane kości ramu firmy '+widget.ram.manufacturer +' powinny być dobrym wyborem. Z nominalną prędkością '+widget.ram.speed+' MHz, zestaw będzie wspierany przez solidną pamięć operacyjną. ';
    }
    if(widget.ram.type=='DDR3'){
      if(int.parse(widget.ram.speed)<1600)ramString+='Wybrane kości ramu firmy '+widget.ram.manufacturer +' nie są wyborem najbardziej optymalnym, ponieważ ich prękość zegara wynosi '
      +widget.ram.speed+' MHz. W przypadku kości DDR3, optymalną prędkością jest 1600 MHz. ';
      else ramString+='Wybrane kości ramu firmy '+widget.ram.manufacturer +' powinny być dobrym wyborem. Z nominalną prędkością '+widget.ram.speed+' MHz, zestaw będzie wspierany przez solidną pamięć operacyjną. ';
    }
    
    //////////////////////Zdania dysku
    String diskString='';
    if(widget.drive.type=='SSD') diskString+='Dysk systemowy jest szybkim dyskiem SSD, który powinien uruchamiać system dużo szybciej niż klasyczne dyski HDD. ';
    else diskString+='Dysk systemowy jest dyskiem HDD, który nie jest zalecany do bycia dyskiem systemowym. Prawdopodobnym jest, że system będzie chodził na nim powoli, a aplikacje mogą niekiedy się zacinać.';
    //////////////////////Zdania psu
    String psuString='';
    if(double.parse(widget.psu.power)<widget.maxTdp)psuString+='Wybrany zasilacz prawdopodobnie nie dostarczy wystarczającej ilości mocy alby zasilić zestaw, '
    +'jako że, przy intensywnej pracy, pobierać może on nawet '+widget.maxTdp.toString()+' W, a nominalna moc zasilacza to jedynie '+widget.psu.power+' W';
    else
    psuString+='Zailacz powinien poradzić sobie z dostarczeniem mocy do zestawu komputerowego, ponieważ jego nominalna moc wynosi '+widget.psu.power.toString()+
    ' W, a zestaw szacunkowo pobierać będzie do '+widget.maxTdp.toString()+' W.';
    ///Zdania case
    String caseString='';
    if(!widget.cases.standard.contains("ATX"))caseString+='Obudowa w tym zestawie nie pozwala na ewentualne rozbudowy systemu do największych standardów płyt głównych. Należy także pamiętać, że w mniejszych obudowach, z reguły można spodziewać się gorszego przepływu powietrza, a co za tym idzie, wyższych temperatur komponentów podczas pracy.';
    else caseString+='Obudowa w tym zestawie wspiera standard ATX który zapewnia kompatybilność ze znaczną większością płyt głównych i zasilaczy na rynku. Ponadto od takiej dużej obudowy, można spodziewać się dobrego przepływu powietrza, potrzebnego do utrzymania optymalnych temperatur w środu zestawu.';
    
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Twój zestaw:',
            style: TextStyle(
                fontFamily: GoogleFonts.workSans().fontFamily,
                color: Colors.white,
                fontSize: 25),
          ),
          for (int i = 0; i < compList.length; i++)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                typeList[i],
                style: TextStyle(
                    fontFamily: GoogleFonts.workSans().fontFamily,
                    color: Colors.white,
                    fontSize: 15),
              ),
              GradientText(
                compList[i] + " ",
                colors: [
                  Color.fromRGBO(142, 223, 255, 1),
                  Color.fromRGBO(142, 223, 255, 1),
                ],
                style: TextStyle(
                    fontFamily: GoogleFonts.workSans().fontFamily,
                    fontSize: 18),
              ),
            ]),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(3),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ])),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(45, 45, 45, 1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [                    
                    Text(
                      cpuString+'\n\n'+mtbString+'\n\n'+gpuString+'\n\n'+ramString+'\n\n'+diskString+'\n\n'+psuString+'\n\n'+caseString,
                      style: style,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(now.toString());
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [buildItems()],
        ),
      ),
    );
  }
}

class PdfUrl {
  String title;
  String link;

  PdfUrl(this.title, this.link);
}

class Links {
  List<PdfUrl> list = [
    PdfUrl('testPdf', 'https://www.sldttc.org/allpdf/21583473018.pdf'),
    PdfUrl('Visual Studio IDE Tutorial', 'https://www.srii.sou.edu.ge/Visual%20Studio%20IDE%20Tutorial.pdf'),
    PdfUrl('NetBeans Manual', 'https://users.cs.fiu.edu/~smithjo/classnotes_2xxxx/netbeans.manual.pdf'),
    PdfUrl('IntelliJ IDEA', 'https://riptutorial.com/Download/intellij-idea.pdf')
  ];
}

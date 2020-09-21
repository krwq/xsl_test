using System;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Xsl;

namespace Transform.TestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument source = new XmlDocument();
            source.LoadXml(File.ReadAllText("Interm_66.xml"));
            string transform = File.ReadAllText("Transform_XML_NoBatch_ISO_66XXL.xslt");

            Console.WriteLine("With Compiled transform");
            var xslCompiledTransform = new XslCompiledTransform();

            using (var xmlReader = ToXmlReader(transform))
            {
                xslCompiledTransform.Load(xmlReader, new XsltSettings(false, true), null);
                using (var objectStream = new MemoryStream())
                {
                    xslCompiledTransform.Transform(source, new XsltArgumentList(), objectStream);

                    objectStream.Seek(0, SeekOrigin.Begin);
                    var stringContent = xslCompiledTransform.OutputSettings.Encoding.GetString(objectStream.ToArray());
#if NETFRAMEWORK
                    xslCompiledTransform.TemporaryFiles.Delete();
#endif

                    Console.WriteLine(stringContent);
                }
            }

            Console.WriteLine("With basic transform");
            var basicTransform = new XslTransform();

            using (var xmlReader = ToXmlReader(transform))
            {
                basicTransform.Load(xmlReader);//, new XsltSettings { EnableScript = true }, null);

                using (var objectStream = new MemoryStream())
                {
                    basicTransform.Transform(source, new XsltArgumentList(), objectStream);
                    objectStream.Seek(0, SeekOrigin.Begin);
                    var stringContent = Encoding.UTF8.GetString(objectStream.ToArray());

#if NETFRAMEWORK
                    basicTransform.TemporaryFiles.Delete();
#endif
                    Console.WriteLine(stringContent);
                    Console.ReadKey();
                }
            }

        }

        public static XmlReader ToXmlReader(string s)
        {
            var sr = new StringReader(s);
            return XmlReader.Create(sr);
        }
    }
}

//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BF.Properties {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "17.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    public class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("BF.Properties.Resources", typeof(Resources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;!--@author Irena Bojanova(ivb)--&gt;
        ///&lt;!--@date - 2/9/2022--&gt;
        ///
        ///&lt;!-- an object contains data and has address, and size; the address and the size are data contained by other objects 
        ///(the address specifically is the data of a pointer) - the data contained by this object and the other objects 
        ///has value and type - we use this level to connect the classes--&gt;
        ///
        ///&lt;!--CHANGE
        ///
        ///Type???
        ///
        ///Object related:
        ///- Improper Size
        ///- Improper Address
        ///- Improper Type 
        ///	- Improper Range
        ///	- Improper Operation
        ///- Improper  [rest of string was truncated]&quot;;.
        /// </summary>
        public static string BF {
            get {
                return ResourceManager.GetString("BF", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;!--@author Irena Bojanova(ivb)--&gt;
        ///&lt;!--@date - 07/09/2021--&gt;
        ///&lt;BFCWE&gt;
        ///	&lt;Cluster Name=&quot;_ALL&quot;&gt;
        ///		&lt;!--fig 1--&gt;
        ///		&lt;showClassCWEs&gt;
        ///			&lt;!--from BF site:--&gt;
        ///			&lt;ClassOperation name=&quot;pillar&quot;&gt;
        ///				&lt;CWE&gt;284&lt;/CWE&gt;
        ///				&lt;CWE&gt;435&lt;/CWE&gt;
        ///				&lt;CWE&gt;664&lt;/CWE&gt;
        ///				&lt;!--&lt;CWE&gt;682&lt;/CWE&gt;--&gt;
        ///				&lt;CWE&gt;691&lt;/CWE&gt;
        ///				&lt;CWE&gt;693&lt;/CWE&gt;
        ///				&lt;!--&lt;CWE&gt;697&lt;/CWE&gt;--&gt;
        ///				&lt;CWE&gt;703&lt;/CWE&gt;
        ///				&lt;CWE&gt;707&lt;/CWE&gt;
        ///				&lt;CWE&gt;710&lt;/CWE&gt;
        ///			&lt;/ClassOperation&gt;
        ///		&lt;/showClassCWEs&gt;
        ///	&lt;/Cluster&gt;
        ///
        ///	&lt;!--Created by Irena Bojanova, 07/09/2021--&gt;
        ///	&lt;C [rest of string was truncated]&quot;;.
        /// </summary>
        public static string BFCWE {
            get {
                return ResourceManager.GetString("BFCWE", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;
        ///&lt;!--@author Irena Bojanova(ivb); *@date - 2/27/2022 --&gt;
        ///&lt;xs:schema attributeFormDefault=&quot;unqualified&quot; elementFormDefault=&quot;qualified&quot; 
        ///		xmlns:xs=&quot;http://www.w3.org/2001/XMLSchema&quot;&gt;
        ///	&lt;xs:element name=&quot;BF&quot;&gt;
        ///		&lt;xs:complexType&gt;
        ///			&lt;xs:sequence&gt;
        ///				&lt;xs:element name=&quot;Cluster&quot; minOccurs=&quot;1&quot; maxOccurs=&quot;unbounded&quot;&gt;
        ///					&lt;xs:complexType&gt;
        ///						&lt;xs:sequence&gt;
        ///							&lt;xs:element ref=&quot;Class&quot; minOccurs=&quot;1&quot; maxOccurs=&quot;unbounded&quot;/&gt;
        ///						&lt;/xs:sequence&gt;
        ///						&lt;xs:attribute  [rest of string was truncated]&quot;;.
        /// </summary>
        public static string BFSchema {
            get {
                return ResourceManager.GetString("BFSchema", resourceCulture);
            }
        }
    }
}

﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace KEVNVDBF.Properties {
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
    internal class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("KEVNVDBF.Properties.Resources", typeof(Resources).Assembly);
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
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to 
        ///&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot; exclude-result-prefixes=&quot;msxsl&quot;&gt;
        ///    &lt;xsl:output method=&quot;xml&quot; indent=&quot;yes&quot;/&gt;
        ///
        ///	&lt;xsl:param name=&quot;Clusters&quot;/&gt;
        ///	&lt;!--&lt;xsl:variable name=&quot;Cluster&quot; select=&quot;$Clusters//Cluster[@Name=&apos;_DAT&apos;]&quot;/&gt;--&gt;
        ///	&lt;xsl:variable name=&quot;Cluster&quot; select=&quot;$Clusters//Cluster[@Name=&apos;_DAT&apos; or @Name=&apos;_MEM&apos;]&quot;/&gt;
        ///	&lt;!--&lt;xsl:variable name=&quot;Cluster&quot; select=&quot;msxsl:node-set($Clusters)/Cluster[not(@Name=&apos;_ALL&apos;)]&quot;/&gt;--&gt;
        /// </summary>
        internal static string BF_CWE_CVE {
            get {
                return ResourceManager.GetString("BF-CWE-CVE", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;
        ///&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot;&gt;
        ///
        ///	&lt;xsl:template match=&quot;/*&quot;&gt;
        ///		&lt;xsl:element name=&quot;KEVNVDBF&quot;&gt;
        ///			&lt;xsl:apply-templates select=&quot;CVE_Items/item&quot; mode=&quot;cve&quot;/&gt;
        ///		&lt;/xsl:element&gt;
        ///    &lt;/xsl:template&gt;
        ///
        ///	&lt;xsl:template match=&quot;*&quot; mode=&quot;cve&quot;&gt;
        ///		&lt;xsl:element name=&quot;CVE&quot;&gt;
        ///			&lt;xsl:attribute name=&quot;Id&quot;&gt;&lt;xsl:value-of select=&quot;cve/CVE_data_meta/ID&quot;/&gt;&lt;/xsl:attribute&gt;
        ///			&lt;xsl:attribute name=&quot;CWE&quot;&gt;&lt;xsl:value-of select=&quot;cve/problemtype/p [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string CVE_CVSS_CWE {
            get {
                return ResourceManager.GetString("CVE-CVSS-CWE", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;
        ///&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot;
        ///    xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot; exclude-result-prefixes=&quot;msxsl&quot;
        ///				xmlns:o=&quot;urn:schemas-microsoft-com:office:office&quot;
        ///         xmlns:x=&quot;urn:schemas-microsoft-com:office:excel&quot;
        ///         xmlns:ss=&quot;urn:schemas-microsoft-com:office:spreadsheet&quot;
        ///         xmlns:html=&quot;http://www.w3.org/TR/REC-html40&quot;
        ///&gt;
        ///    &lt;xsl:output method=&quot;xml&quot; indent=&quot;yes&quot;/&gt;
        ///
        ///	&lt;xsl:template match=&quot;/*&quot; [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string KEV_NVD_BF_excel {
            get {
                return ResourceManager.GetString("KEV-NVD-BF-excel", resourceCulture);
            }
        }
    }
}
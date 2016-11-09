using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(webanhnguyen.Startup))]
namespace webanhnguyen
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

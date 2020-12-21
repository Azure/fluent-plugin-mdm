MDM Out Plugin
======

## Installation
     gem install fluent-plugin-mdm

## Configuration
* `host` - MDM's statsd frontend endpoint. String, default: '0.0.0.0'
* `port` - MDM's statsd frontend port. Integer, default '8125'

### Sample configuration
```
<match heartbeat.mdm.**>
  @type mdm
  host 172.17.0.1
  port 8125
</match>
```

## Usage
This plugin expects the following fields to be present on the record
* `Namespace` - Metric grouping for this event.
* `Metric` - Actual metric name for which this event is being emitted.
* `Dims` - Map of the dimension describing this metric.
* `Value` - Metric value to be emitted.

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks 

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft trademarks or logos is subject to and must follow Microsoft's Trademark & Brand Guidelines. Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship. Any use of third-party trademarks or logos are subject to those third-party's policies.

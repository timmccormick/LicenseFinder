module LicenseFinder
  class NpmPackage < Package
    def initialize(spec, options={})
      super(
        spec["name"],
        spec["version"],
        options.merge(
          description: spec["description"],
          homepage: spec["homepage"],
          spec_licenses: Package.license_names_from_standard_spec(spec),
          install_path: spec["path"],
          children: spec.fetch("dependencies", {}).map { |_, d| d["name"] }
        )
      )
    end
  end
end

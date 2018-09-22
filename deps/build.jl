using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libecos"], :ecos),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaOpt/ECOSBuilder/releases/download/v2.0.5-multigcc"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.aarch64-linux-gnu-gcc4.tar.gz", "cf0444109f4c77c1d3718f4150c22dab64b8fd02b64cbb44d9ce39a3b789f5a1"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.aarch64-linux-gnu-gcc7.tar.gz", "7fbd076fc389111414850703a2d3b8d73bfc72fbdb04f3eaaa01106569054755"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.aarch64-linux-gnu-gcc8.tar.gz", "1d11d62a9d96768190fc794d3a1f4643cb65ea7b0d4daef1e47f13b212d14414"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.aarch64-linux-musl-gcc4.tar.gz", "13b416bd22cad2559477889a6fbaf92cca050b66e5af65710c22077d5775a203"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.aarch64-linux-musl-gcc7.tar.gz", "2b082e4d75040bd6ed72ef3176c1e9ac0b9f089393b527ee6e2a866db36f2792"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.aarch64-linux-musl-gcc8.tar.gz", "dff364a3ca2adad0e956a974ecda0de3184b30c143c78a5c42d41a9cf0d590f4"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.arm-linux-gnueabihf-gcc4.tar.gz", "f8c20ffbed4a8a09cad9c4e3a6a505c4162217e2f506839419bdf090377b176a"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.arm-linux-gnueabihf-gcc7.tar.gz", "2554c28ae06c702c2f3c96c3709131237e591a4e5214f65bb0b50ad88c4ac2ea"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.arm-linux-gnueabihf-gcc8.tar.gz", "29d637c5874212e218dc7a0b98e6c9f379192ed0001c376a6ca27164f07a856d"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.arm-linux-musleabihf-gcc4.tar.gz", "fbeb56b006bbc230778b738a08dc7bffa3468869fc0f065f070e73c781974799"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.arm-linux-musleabihf-gcc7.tar.gz", "a61119cc35e3f7dd60ecbe9868753515ce0547b12b889a7ae5cd4cc8e3d170de"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.arm-linux-musleabihf-gcc8.tar.gz", "cb15a51139d3e659573d2436fdce633cfd081cc42a506ecddfe1e0b35c97d9f1"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-linux-gnu-gcc4.tar.gz", "cd2664a9d334d6ff4dbe9827e36da5643c76c1db29ccbae4b342bc0c0e3b7200"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-linux-gnu-gcc7.tar.gz", "614c0a97ec35bfc818a0bf0a3d1e570b2a68afaa0c243cee45fb3b05d1ac5b88"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-linux-gnu-gcc8.tar.gz", "bb385863679b01eac73dcfe210d928cdf4b971dad99d8eec31b2e89964c65f99"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-linux-musl-gcc4.tar.gz", "3dd3bd255a83118c593d7d5b6bafb52dfc53615cde07d9f253537237abd5656a"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-linux-musl-gcc7.tar.gz", "773070ec6391f37be7ffb674a50c324fb808a2e9b8c1fc509c95018b04135c05"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-linux-musl-gcc8.tar.gz", "552e598cf17b11d1f8c8ec28c39018b978db629eed4e730a8c5e4d2e580688fd"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-w64-mingw32-gcc4.tar.gz", "bdd5d6bd5b9149754691e2ad1b310bbb1ba8caf146c7256cabbf60a74c008dab"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-w64-mingw32-gcc7.tar.gz", "96cebc4359906b05e52fab291f7780261e6d83a55779acb2db69ee61d6c6a6fa"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.i686-w64-mingw32-gcc8.tar.gz", "4ee2cd7b58dea0f622383a20b0145a2b73c2086ce691755b480008f5ae14c722"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.powerpc64le-linux-gnu-gcc4.tar.gz", "4f8628bdd10b32f2658bb2cd9033d3ad505b4a685a4fb18b87f52417224cb230"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.powerpc64le-linux-gnu-gcc7.tar.gz", "4c37286390c0dd59075742d32f02acc71eb05c2166851db50eaa1b347c873186"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.powerpc64le-linux-gnu-gcc8.tar.gz", "aa7daaa623d647c1bf6688b90d6cb1a478e3a71bfb2249f6e71b1bca710b1249"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-apple-darwin14-gcc4.tar.gz", "c10012bf0be2a894d37c65234d315d84fc93a3a6f42e47aa0491510f6b282551"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-apple-darwin14-gcc7.tar.gz", "c9fe92b106643e1abb57700446ade42f2369463e702ddfc1e21a59bfe6beeca2"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-apple-darwin14-gcc8.tar.gz", "64b5672428a82ce9ff35d04111f3be39f1c4e58ef365e959c27298de0404bdd5"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-linux-gnu-gcc4.tar.gz", "98f7c55ede20158671b31bd7f6367667d66ff6a26b057944771bb36a740e4e69"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-linux-gnu-gcc7.tar.gz", "0c48980d761c7b261fb62c56f7a9ddb2f005c029025fff3b89204ed73622a395"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-linux-gnu-gcc8.tar.gz", "7a14789220990045f8ecf918b8ae76d350028ee3e8c10d214e7fcf2313c05e12"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-linux-musl-gcc4.tar.gz", "af732c593aebdc35c7f64a1664d717fac9cebee73f99fbd721e0b6f52352a70e"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-linux-musl-gcc7.tar.gz", "2010f2d8ed921276e5820f1b09b2a036fb98809522284bcfcd041d68b8b0f86a"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-linux-musl-gcc8.tar.gz", "e246872784f38a88a2e0471ccc0820e10142adae7c7b62b77a7c51d5300e88c1"),
    FreeBSD(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-unknown-freebsd11.1-gcc4.tar.gz", "3a4b37841002894a99df04c40f993b3c4e18524a5441a04b7d788cd176022449"),
    FreeBSD(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-unknown-freebsd11.1-gcc7.tar.gz", "2ee6d60b328869b6ab012dd3d72a8f859157ca5ff1b9989d0ff6454d46ef7745"),
    FreeBSD(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-unknown-freebsd11.1-gcc8.tar.gz", "27c017b158134a556fc03be371097a852e96f717dcc7e5a8231f075b8d6c10d1"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-w64-mingw32-gcc4.tar.gz", "a7db2f634f3a57f608e854db96f158722ca5a7c79524d66e6414df1d030217a5"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-w64-mingw32-gcc7.tar.gz", "347ef3749892686e9b68f73bba22854970a02d5a41e05e2b3591b361193f8a6c"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/ECOSBuilder.v2.0.5.x86_64-w64-mingw32-gcc8.tar.gz", "d2bc7b9f7323ef791cb30787206362e7c41c618860d462b9695e87729bc1867c"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
dl_info = choose_download(download_info)
if dl_info === nothing && unsatisfied
    # If we don't have a compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
end

# If we have a download, and we are unsatisfied (or the version we're
# trying to install is not itself installed) then load it up!
if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
    # Download and install binaries
    install(dl_info...; prefix=prefix, force=true, verbose=verbose)
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
